//
//  InnoConverterVideoType.swift
//  InnoVideoConverteriOS
//
//  Created by Andi Septiadi on 10/01/22.
//

import Foundation

public enum InnoConverterVideoType {
    case mpeg4
    
    public var extensionString: String {
        switch self {
        case .mpeg4: return "mp4"
        }
    }
    
    public var codec: String {
        switch self {
        case .mpeg4: return "mpeg4"
        }
    }
}
