//
//  UIColorExtension.swift
//  creams
//
//  Created by Rawlings on 22/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}

extension UIColor {

    class var backgroundColor: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }

    convenience init(gray: CGFloat) {
        self.init(r: gray, g: gray, b: gray, a: 1)
    }
}
