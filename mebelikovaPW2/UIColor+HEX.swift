//
//  UIColor+HEX.swift
//  mebelikovaPW2
//
//  Created by Мария Беликова on 28.09.2023.
//

import UIKit

// MARK: - UIColor extension (init with HEX)

extension UIColor {
    enum Constants {
        static let maxValueOfHex : Int64 = 16777216
        static let redShift: Int64 = 16
        static let greenShift: Int64 = 8
        static let normalizedNumber: CGFloat = 255
    }
    
    convenience init(hex: String) {
        let r, g, b : CGFloat
        let scanner = Scanner(string: hex)
        var hexNumber : UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat(((hexNumber & 0xff0000) >> Constants.redShift)) / Constants.normalizedNumber
            g = CGFloat(((hexNumber & 0x00ff00) >> Constants.greenShift)) / Constants.normalizedNumber
            b = CGFloat((hexNumber & 0x0000ff)) / Constants.normalizedNumber
            self.init(red: r, green: g, blue: b, alpha: 1)
            return
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private static func getRandomHex() -> String {
        let number = Int64.random(in: 0..<Constants.maxValueOfHex)
        var hexString: String
        hexString = String(format:"%06x", number)
        return hexString
    }
    
    static func getRandomColor() -> UIColor {
        return UIColor(hex: getRandomHex())
    }
}


