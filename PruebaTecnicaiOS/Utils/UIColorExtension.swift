//
//  UIColorExtension.swift
//  PruebaTecnicaiOS
//
//  Created by Satoritech 15 on 02/06/22.
//

import UIKit

extension UIColor {

    // MARK: - Initialization

    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    // MARK: - Computed Properties

    var toHex: String? {
        return toHex()
    }

    // MARK: - From UIColor to String

    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    class var darkishPink: UIColor {
        return UIColor(red: 214.0 / 255.0, green: 60.0 / 255.0, blue: 106.0 / 255.0, alpha: 1.0)
        
    }
    
    class var lightSalmon: UIColor {
        return UIColor(red: 249.0 / 255.0, green: 162.0 / 255.0, blue: 138.0 / 255.0, alpha: 1.0)
        
    }
    
    class var purpleishBlueThree: UIColor {
        
        return UIColor(red: 63.0 / 255.0, green: 71.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
        
    }
    
    class var brightLilac: UIColor {
        
        return UIColor(red: 220.0 / 255.0, green: 119.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
    }
    
    class var dustyOrange: UIColor {
        
        return UIColor(red: 248.0 / 255.0, green: 138.0 / 255.0, blue: 47.0 / 255.0, alpha: 1.0)
        
    }
    
    class var lightMustard: UIColor {
        
        return UIColor(red: 250.0 / 255.0, green: 202.0 / 255.0, blue: 88.0 / 255.0, alpha: 1.0)
        
    }
    
    class var greenyBlue: UIColor {
        
        return UIColor(red: 71.0 / 255.0, green: 194.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
        
    }
    
    class var hospitalGreen: UIColor {
        
        return UIColor(red: 129.0 / 255.0, green: 220.0 / 255.0, blue: 161.0 / 255.0, alpha: 1.0)
        
    }

}

extension Date{
    
    func getCurrentDateString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
        
        return formatter.string(from: self)
        
    }
    
}

