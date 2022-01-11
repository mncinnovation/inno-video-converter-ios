//
//  InnoConverterMapper.swift
//  InnoVideoConverteriOS
//
//  Created by Andi Septiadi on 11/01/22.
//

import UIKit

class InnoConverterMapper {
    class func string(withSize size: CGSize) -> String {
        NSString(format: "%@:%@", size.width.cleanString(), size.height.cleanString()) as String
    }
}
