//
//  ImageTitleSubtitleArrange.swift
//  creams
//
//  Created by shying li on 2018/1/15.
//  Copyright © 2018年 creams.io. All rights reserved.
//

import Foundation

struct ImageTitleSubtitleArrange: Arrangeable {
    
    /// ImageTitleSubtitleArrange
    ///
    /// - Parameters:
    ///   - elements: first: ImageElement 1: TitleElement last: SubTitleElement
    ///   - container:
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 3)
        
        elements.forEach { (ele) in
            container.addSubview(ele)
        }

        guard let imageEle = elements.first, imageEle is UIImageView else { return }

        imageEle.snp.makeConstraints({ make in
            make.left.equalTo(container.snp.left).offset(10)
            make.centerY.equalToSuperview()
        })

        let titleEle = elements[1]
        if titleEle is UILabel {
            titleEle.snp.makeConstraints({ (make) in
                make.left.equalTo(imageEle.snp.right).offset(10.9)
                make.top.equalTo(container.snp.top).offset(16)
                make.right.equalToSuperview().offset(-10)
            })
        }

        if let subTitleEle = elements.last, subTitleEle is UILabel {
            subTitleEle.snp.makeConstraints({ (make) in
                make.left.equalTo(imageEle.snp.right).offset(10.9)
                make.bottom.equalTo(container.snp.bottom).offset(-10)
                make.right.equalTo(titleEle)
            })
        }
    }
}
