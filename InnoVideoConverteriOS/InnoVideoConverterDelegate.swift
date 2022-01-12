//
//  InnoVideoConverterDelegate.swift
//  InnoVideoConverteriOS
//
//  Created by Andi Septiadi on 11/01/22.
//

import Foundation

public protocol InnoVideoConverterDelegate: AnyObject {
    func innoVideoConverter(inProgressAtConverter converter: InnoVideoConverter, percentage: Int)
    func innoVideoConverter(didSuccessAtConverter converter: InnoVideoConverter, videoPath: String)
    
    // MARK: - Optional
    func innoVideoConverter(beginExecuteAtConverter converter: InnoVideoConverter)
    func innoVideoConverter(didReceivedLogAtConverter converter: InnoVideoConverter, log: String)
    func innoVideoConverter(didErrorAtConverter converter: InnoVideoConverter, error: String)
}

public extension InnoVideoConverterDelegate {
    func innoVideoConverter(beginExecuteAtConverter converter: InnoVideoConverter) {}
    func innoVideoConverter(didReceivedLogAtConverter converter: InnoVideoConverter, log: String) {}
    func innoVideoConverter(didErrorAtConverter converter: InnoVideoConverter, error: String) {}
}
