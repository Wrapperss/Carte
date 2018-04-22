//
//  CGSize+Extension.swift
//  creams
//
//  Created by hasayakey on 9/22/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Foundation

extension CGSize {

    func expand(by factor: CGFloat) -> CGSize {
        return CGSize(width: width * factor, height: height * factor)
    }
}
