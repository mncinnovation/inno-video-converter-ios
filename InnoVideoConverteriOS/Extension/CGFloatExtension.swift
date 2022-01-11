//
//  CGFloatExtension.swift
//  InnoVideoConverteriOS
//
//  Created by Andi Septiadi on 11/01/22.
//

import Foundation
import UIKit

extension CGFloat {
    func cleanString() -> String {
        self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", Double(self)) : String(Double(self))
    }
}
