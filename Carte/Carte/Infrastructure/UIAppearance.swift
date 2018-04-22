//
//  UIAppearance.swift
//  creams
//
//  Created by hasayakey on 9/8/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import UIKit
import UIFontComplete
import IQKeyboardManagerSwift

internal func configAppearance() {
    
    IQKeyboardManager.sharedManager().enable = true
    IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "完成"
    
    UINavigationBar.appearance().tintColor = UIColor.black
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().barStyle = .default
    UINavigationBar.appearance().shadowImage = UIImage.imageWithColor(color: UIColor(white: 224.0 / 255.0, alpha: 1.0))
    UINavigationBar.appearance().setBackgroundImage( UIImage.imageWithColor(color: .white), for: .default)
    
    let navbarTitleTextAttributes = [
        NSForegroundColorAttributeName: UIColor.black,
        NSFontAttributeName: UIFont(name: Font.pingFangSCLight.rawValue, size: 18)!
    ]
    
    UINavigationBar.appearance().titleTextAttributes = navbarTitleTextAttributes
    
    HUD.defaultDeploy()
    
    if #available(iOS 10, *) {
        UICollectionView.appearance().isPrefetchingEnabled = false
    }
    UICollectionView.appearance().alwaysBounceVertical = true
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
    
    class var charcoalGrey: UIColor {
        return UIColor(red: 53.0 / 255.0, green: 59.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0)
    }
    
    class var greenishTeal: UIColor {
        return UIColor(red: 55.0 / 255.0, green: 210.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
    }
    
    class var steel: UIColor {
        return UIColor(red: 130.0 / 255.0, green: 134.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    }
    
    class var steelTwo12: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.12)
    }
    
    class var whiteTwo: UIColor {
        return UIColor(white: 224.0 / 255.0, alpha: 1.0)
    }
    
    class var darkSkyBlue: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 148.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
    }
    
    class var darkSkyBlueTwo: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 148.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }
    
    class var creamsBlue: UIColor {
        return darkSkyBlue
    }
    
    class var black30: UIColor {
        return UIColor(white: 0.0, alpha: 0.3)
    }
    
    class var silver: UIColor {
        return UIColor(red: 195.0 / 255.0, green: 198.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }
    
    class var white80: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 0.8)
    }
    
    class var black10: UIColor {
        return UIColor(white: 0.0, alpha: 0.1)
    }
    
    class var coolGrey: UIColor {
        return UIColor(red: 146.0 / 255.0, green: 153.0 / 255.0, blue: 160.0 / 255.0, alpha: 1.0)
    }
    
    class var greenishTealTwo: UIColor {
        return UIColor(red: 50.0 / 255.0, green: 190.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
    }
    
    class var lightishRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 49.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
    }
    
    class var paleGrey: UIColor {
        return UIColor(red: 234.0 / 255.0, green: 235.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
    
    class var whiteThree: UIColor {
        return UIColor(white: 238.0 / 255.0, alpha: 1.0)
    }
    
    class var mango: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 147.0 / 255.0, blue: 41.0 / 255.0, alpha: 1.0)
    }
    
    class var paleGreyTwo: UIColor {
        return UIColor(red: 235.0 / 255.0, green: 239.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
    }
    
    class var blueGrey: UIColor {
        return UIColor(red: 112.0 / 255.0, green: 133.0 / 255.0, blue: 161.0 / 255.0, alpha: 1.0)
    }
    
    class var whiteFour: UIColor {
        //        return UIColor(white: 248.0 / 255.0, alpha: 1.0)
        return UIColor(r: 224, g: 224, b: 224)
    }
    
    class var lightRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 60.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
    }
    
    class var brightBlue: UIColor {
        return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var greyishBrown78: UIColor {
        return UIColor(white: 77.0 / 255.0, alpha: 0.78)
    }
    
    class var greyishBrown: UIColor {
        return UIColor(white: 77.0 / 255.0, alpha: 1.0)
    }
    
    class var seafoamBlue: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 215.0 / 255.0, blue: 198.0 / 255.0, alpha: 1.0)
    }
    
    class var darkPeach: UIColor {
        return UIColor(red: 220.0 / 255.0, green: 123.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
    }
    
    class var carnationPink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 117.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
    }
    
    class var peach: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 164.0 / 255.0, blue: 118.0 / 255.0, alpha: 1.0)
    }
    
    class var sunYellow: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 209.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    
    class var custard: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
    }
    
    class var fadedBlue: UIColor {
        return UIColor(red: 118.0 / 255.0, green: 163.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }
    
    class var seafoamBlueTwo: UIColor {
        return UIColor(red: 101.0 / 255.0, green: 215.0 / 255.0, blue: 198.0 / 255.0, alpha: 1.0)
    }
    
    class var dodgerBlue: UIColor {
        return UIColor(red: 62.0 / 255.0, green: 146.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
    }
    
    class var aquaMarine: UIColor {
        return UIColor(red: 63.0 / 255.0, green: 236.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
    }
    
    class var perrywinkle: UIColor {
        return UIColor(red: 144.0 / 255.0, green: 187.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    }
    
    class var salmon: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 129.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)
    }
    
    class var lightishBlue: UIColor {
        return UIColor(red: 51.0 / 255.0, green: 108.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
    }
    
    class var greenishTealThree: UIColor {
        return UIColor(red: 57.0 / 255.0, green: 209.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0)
    }
    
    class var greenishTealFour: UIColor {
        return UIColor(red: 72.0 / 255.0, green: 209.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0)
    }
    
    class var dark: UIColor {
        return UIColor(red: 41.0 / 255.0, green: 45.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
    }
    
    class var lipstick: UIColor {
        return UIColor(red: 226.0 / 255.0, green: 34.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
    }
    
    class var darkTwo: UIColor {
        return UIColor(red: 30.0 / 255.0, green: 34.0 / 255.0, blue: 47.0 / 255.0, alpha: 1.0)
    }
    
    class var brick: UIColor {
        return UIColor(red: 195.0 / 255.0, green: 44.0 / 255.0, blue: 43.0 / 255.0, alpha: 1.0)
    }
    
}

