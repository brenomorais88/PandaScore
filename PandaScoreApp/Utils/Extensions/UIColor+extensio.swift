//
//  UIColor+extensio.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8)  / 255.0
        let blue  = CGFloat( hex & 0x0000FF)        / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init?(hexString: String) {
        var hex = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }

        guard hex.count == 6 || hex.count == 8,
              let hexValue = UInt(hex, radix: 16) else {
            return nil
        }

        let hasAlpha = (hex.count == 8)
        let divisor: CGFloat = 255.0

        let red:   CGFloat
        let green: CGFloat
        let blue:  CGFloat
        let alpha: CGFloat

        if hasAlpha {
            red   = CGFloat((hexValue & 0xFF000000) >> 24) / divisor
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / divisor
            blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / divisor
            alpha = CGFloat( hexValue & 0x000000FF)        / divisor
        } else {
            red   = CGFloat((hexValue & 0xFF0000) >> 16) / divisor
            green = CGFloat((hexValue & 0x00FF00) >> 8)  / divisor
            blue  = CGFloat( hexValue & 0x0000FF)        / divisor
            alpha = 1.0
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }


    //MARK: Colors
    static let background = UIColor(hex: 0x161621)
}
