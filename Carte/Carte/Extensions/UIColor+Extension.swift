//
//  UIColor+Extension.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
extension UIColor {
    class var backgroundColor: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
}

internal func emptyLabel(message: String = "暂无查询记录") -> UILabel {
    let label = UILabel()
    label.text = message
    label.textColor = UIColor.steel
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    return label
}


extension UIColor {
    
    class var darkSkyBlue: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 148.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
    }
    
    class var dustyPink: UIColor {
        return UIColor(hexString: "df8c90")!
    }
    
    class var paleSkyBlue: UIColor {
        return UIColor(hexString: "c8e0ff")!
    }
    
    class var clearBlue: UIColor {
        return UIColor(hexString: "2389f6")!
    }
    
    class var coolGreyTwo: UIColor {
        return UIColor(red: 146.0 / 255.0, green: 153.0 / 255.0, blue: 160.0 / 255.0, alpha: 1.0)
    }
    
    class var pinkishGrey: UIColor {
        return UIColor(white: 209.0 / 255.0, alpha: 1.0)
    }
    
    class var steel: UIColor {
        return UIColor(hexString: "828692")!
    }
    
    class var disable: UIColor {
        return UIColor.init(gray: 208)
    }
    
    class var paleGreyThree: UIColor {
        return UIColor(hexString: "dcdbdc")!
    }
    
    class var whiteTwo: UIColor {
        return UIColor(white: 224.0 / 255.0, alpha: 1.0)
    }
    
    class var charcoalGrey: UIColor {
        return UIColor(red: 53.0 / 255.0, green: 59.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0)
    }
    
    class var coolGrey: UIColor {
        return UIColor(red: 147.0 / 255.0, green: 149.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
    }
    
    class var dark: UIColor {
        return UIColor(red: 37.0 / 255.0, green: 40.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
    }
    
    class var lightRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 60.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
    }
    
    class var brownishGrey: UIColor {
        return UIColor(hexString: "696969")!
    }
    
    class var softBlue: UIColor {
        return UIColor(hexString: "5e9feb")!
    }
    
    class var defaultGray: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    
    class var darkGray: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    
    class var waterBlue: UIColor {
        return UIColor(red: 20.0 / 255.0, green: 116.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0)
    }
    
    class var whiteThree: UIColor {
        return UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
    }
    
    class var whiteSeven: UIColor {
        return UIColor(hexString: "eeeeee")!
    }
    
    class var whiteNine: UIColor {
        return UIColor(hexString: "dddddd")!
    }
    
    class var tangerine: UIColor {
        return UIColor(hexString: "ff8d1f")!
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func creamsRandomColor() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(gray: CGFloat) {
        self.init(gray, gray, gray, 1)
    }
}

// MARK: - Hex

public extension UIColor {
    
    public convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    public convenience init?(hex: Int, alpha: Float) {
        
        var hexString = String(format: "%2x", hex)
        let maxCharactersCount = 6
        
        if hexString.count > maxCharactersCount {
            let lastCharacterIndex = hexString.index(hexString.startIndex, offsetBy: maxCharactersCount)
            hexString = hexString.substring(to: lastCharacterIndex)
        }
        
        let acceptableCharacterSet = CharacterSet(charactersIn: "abcdefABCDEF0123456789")
        hexString = String(hexString.filter({
            String($0).rangeOfCharacter(from: acceptableCharacterSet) != nil
        }))
        
        let additionalCharactersCount = maxCharactersCount - hexString.count
        let additionalZeroString = String(repeating: "0", count: additionalCharactersCount)
        hexString = additionalZeroString + hexString
        
        self.init(hexString: hexString, alpha: alpha)
    }
    
    public convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    public convenience init?(hexString: String, alpha: Float) {
        
        var hexString = hexString
        if hexString.hasPrefix("#") {
            let prefixIndex = hexString.index(hexString.startIndex, offsetBy: 1)
            hexString = hexString.substring(from: prefixIndex)
        }
        
        let regularExpression = "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)"
        let range = hexString.range(of: regularExpression, options: .regularExpression, range: nil, locale: nil)
        guard range != nil else {
            return nil
        }
        
        if hexString.count == 3 {
            let firstCharacterIndex = hexString.index(hexString.startIndex, offsetBy: 1)
            let lastCharacterIndex = hexString.index(hexString.endIndex, offsetBy: -1)
            
            let firstCharacter = hexString.substring(to: firstCharacterIndex)
            let secondCharacter = hexString.substring(from: firstCharacterIndex).substring(to: firstCharacterIndex)
            let thirdCharacter = hexString.substring(from: lastCharacterIndex)
            
            hexString = firstCharacter + firstCharacter
            hexString += secondCharacter + secondCharacter
            hexString += thirdCharacter + thirdCharacter
        }
        
        let firstCharactersPairIndex = hexString.index(hexString.startIndex, offsetBy: 2)
        let lastCharactersPairIndex = hexString.index(hexString.endIndex, offsetBy: -2)
        
        let redHexString = hexString.substring(to: firstCharactersPairIndex)
        let greenHexString = hexString.substring(from: firstCharactersPairIndex).substring(to: firstCharactersPairIndex)
        let blueHexString = hexString.substring(from: lastCharactersPairIndex)
        
        var redInt: UInt32 = 0
        var greenInt: UInt32 = 0
        var blueInt: UInt32 = 0
        
        Scanner(string: redHexString).scanHexInt32(&redInt)
        Scanner(string: greenHexString).scanHexInt32(&greenInt)
        Scanner(string: blueHexString).scanHexInt32(&blueInt)
        
        let redFloat = CGFloat(redInt) / 255.0
        let greenFloat = CGFloat(greenInt) / 255.0
        let blueFloat = CGFloat(blueInt) / 255.0
        
        self.init(red: redFloat, green: greenFloat, blue: blueFloat, alpha: CGFloat(alpha))
    }
}
