//
//  Adaptor.swift
//  creams
//
//  Created by Rawlings on 23/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit

struct Adaptor {
    static let designedSize = CGSize(width: 375, height: 667)
}

// MARK: - Size

extension Adaptor {

    static func widthFitting(_ width: CGFloat) -> CGFloat {
        return width / designedSize.width * UIScreen.screenWidth
    }

    static func heightFitting(_ height: CGFloat) -> CGFloat {
        return height / designedSize.height * UIScreen.screenHeight
    }

    static func textWidth(_ text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let attributes = [NSFontAttributeName: font]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.width)
    }

    static func textHeight(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSFontAttributeName: font]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height)
    }

}
