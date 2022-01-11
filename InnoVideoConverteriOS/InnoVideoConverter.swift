//
//  InnoVideoConverter.swift
//  InnoVideoConverteriOS
//
//  Created by Andi Septiadi on 11/01/22.
//

import Foundation
import ffmpegkit
import AVFoundation

public final class InnoVideoConverter {
    private var videoSourcePath: String
    private var videoResultName: String
    private var asset: AVAsset
    private var duration: Float
    
    public weak var delegate: InnoVideoConverterDelegate?
    public var videoQuality: InnoConverterQuality = .medium
    public var convertSpeed: InnoConverterSpeed = .medium
    public var tag: Int = 0
    public var scale: CGSize?
    public var videoType: InnoConverterVideoType = .mpeg4
    
    private var resultPath: String?
    
    public init(videoSourcePath path: String,
                videoResultName name: String,
                convertResultVideoScale scale: CGSize? = nil,
                tag: Int = 0,
                convertQuality quality: InnoConverterQuality = InnoConverterQuality.medium,
                convertResultVideoType type: InnoConverterVideoType = InnoConverterVideoType.mpeg4,
                convertSpeed speed: InnoConverterSpeed = InnoConverterSpeed.medium) {
        
        self.videoSourcePath = path
        self.videoResultName = name
        
        self.videoType = type
        self.scale = scale
        self.tag = tag
        self.videoQuality = quality
        self.convertSpeed = speed
        
        let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        resultPath = directory + "/" + name + "." + videoType.extensionString
        
        asset = AVAsset(url: URL.init(fileURLWithPath: path))
        let seconds = CMTimeGetSeconds(asset.duration)
        duration = Float(seconds)
    }
}

// MARK: - Public Methods

extension InnoVideoConverter {
    public func convert() {
        self.delegate?.innoVideoConverter(beginExecuteAtConverter: self)
        FFmpegKit.executeAsync(ffmpegCommand()) { aSession in
            guard let aSession = aSession else { return }
            let state = aSession.getState()
            let returnCode = aSession.getReturnCode()
            
            if ReturnCode.isSuccess(returnCode) {
                DispatchQueue.main.async {
                    self.delegate?
                        .innoVideoConverter(
                            didSuccessAtConverter: self,
                            videoPath: self.resultPath ?? ""
                        )
                }
            } else {
                let error = "Encode failed with state \(FFmpegKitConfig.sessionState(toString: state) ?? "") and rc \(returnCode!).\(aSession.getFailStackTrace() ?? "")"
                self.delegate?.innoVideoConverter(didErrorAtConverter: self, error: error)
            }
        } withLogCallback: { log in
            self.delegate?
                .innoVideoConverter(
                    didReceivedLogAtConverter: self,
                    log: log?.getMessage() ?? ""
                )
        } withStatisticsCallback: { statistic in
            guard let statistic = statistic else { return }
            let seconds = self.seconds(millisecond: Float(statistic.getTime()))
            let progress = self.progressPercentation(currentSecond: seconds)
            self.delegate?
                .innoVideoConverter(
                    inProgressAtConverter: self,
                    percentage: progress
                )
        }
    }
    
    public func cancel() {
        FFmpegKit.cancel()
    }
}

// MARK: - Private Methods

extension InnoVideoConverter {
    private func ffmpegCommand() -> String {
        var strings: [String] = []
        strings.append("-i \(videoSourcePath)")
        
        if let scale = scale {
            strings.append("-vf scale=\(InnoConverterMapper.string(withSize: scale))")
        }
        
        strings.append("-crf \(videoQuality.rawValue)")
        strings.append("-preset \(convertSpeed)")
        strings.append("-c:v libx264")
        strings.append(resultPath ?? "")
        
        return strings.joined(separator: " ")
    }
    
    private func seconds(millisecond: Float) -> Float {
        millisecond / 1000
    }
    
    private func progressPercentation(currentSecond: Float) -> Int {
        if currentSecond == 0 { return 0 }
        return Int(currentSecond / duration * 100)
    }
}
