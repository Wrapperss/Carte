//
//  CustomFormItemDemo.swift
//  creams
//
//  Created by Rawlings on 11/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation

//    __________________________
//   |  ____                    |
//   | |    |  &&&&&            |
//   | |____|  *****            |
//   |__________________________|

class CustomFormItemDemo: FormItem {
    
    struct Required {
        let img: String
        let title: String
        let subTitle: String
    }
    
    init(model: Required) {
        
        let img = ImageElement(.local(img: model.img, size: nil, highlightedImg: nil))
        
        let title = TextElement(text: NSAttributedString.attribute(model.title, .black, fontSize: 14))
        let subTitle = TextElement(text: NSAttributedString.attribute(model.subTitle, .black, fontSize: 14))
        
        let wrapper = WrapperElement(elements: [title, subTitle],
                                     arrange: TwoArrange.Vertical.central(5),
                                     size: CGSize(width: 10, height: 10))
        
        let box = FormLayoutBox(elements: [img, wrapper],
                                arrange: TwoArrange.Horizontal.spacingLeading((15, 60)),
                                size: CGSize(width: UIScreen.screenWidth, height: 60))
        
        super.init(box: box)
    }
}

