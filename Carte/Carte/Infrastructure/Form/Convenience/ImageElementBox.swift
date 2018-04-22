//
//  ImageElementBox.swift
//  CreamsAgent
//
//  Created by Rawlings on 14/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation

extension ImageElement {
    
    static func rightArrow(_ tintColor: UIColor? = nil) -> ImageElement {
        let img = ImageElement(ImageElement.Source.local(img: "ic_arrow_mini_right",
                                                      size: CGSize(width: 6, height: 11),
                                                      highlightedImg: nil))
        img.tintColor = tintColor
        return img
    }
}
