//
//  UIScreenExtension.swift
//  creams
//
//  Created by Rawlings on 23/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit

extension UIScreen {

    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    class var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

    static var iphoneX: Bool {
        return UIScreen.main.bounds.height == 812
    }

}
