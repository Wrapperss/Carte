//
//  UIImageView+KingFisher.swift
//  creams
//
//  Created by hasayakey on 9/22/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Kingfisher

extension UIImageView {

    func loadImage(url: URL) {
        kf.setImage(with: url.downloadURL,
                    placeholder: nil,
                    options: kingfisherOptions,
                    progressBlock: nil,
                    completionHandler: nil)
    }

    func loadImage(url: URL, options: KingfisherOptionsInfo) {
        kf.setImage(with: url.downloadURL,
                    placeholder: nil,
                    options: options,
                    progressBlock: nil,
                    completionHandler: nil)
    }

    var kingfisherOptions: KingfisherOptionsInfo {
        let processor = ResizingImageProcessor(referenceSize: bounds.size.expand(by: 3.0),
                                               mode: .aspectFit)
        return [KingfisherOptionsInfoItem.processor(processor),
                KingfisherOptionsInfoItem.transition(.fade(0.3)),
                KingfisherOptionsInfoItem.backgroundDecode]
    }
}
