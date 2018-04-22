//
//  ImageElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 26/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import Kingfisher
import IGListKit

class ImageElement: Element, AssociateItemRequired {
    
    enum Source {
        case local(img: String, size: CGSize?, highlightedImg: String?)
        case web(url: String, size: CGSize, placeholder: String?)
    }
    
    weak var associatedItem: ListDiffable?
    private var priority: Priority = .default
    
    var imageView: UIImageView?
    let source: Source
    let contentMode: UIViewContentMode?
    var tintColor: UIColor? {
        didSet{
            if let tint = tintColor, let imgV = imageView {
                imgV.tintColor = tint
                imgV.image = imgV.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
        }
    }
    let config: ((UIImageView) -> ())?
    
    init(_ source: Source, contentMode: UIViewContentMode? = nil, config: ((UIImageView) -> ())? = nil) {
        self.source = source
        self.contentMode = contentMode
        self.config = config
    }
    
    @discardableResult
    public func priority(_ priority: Priority) -> ImageElement {
        self.priority = priority
        return self
    }
    
    func generateViewWrapper() -> ViewWrapper {
        
        switch source {
            
        case let .local(img, size, highlightedImg):
            let image = UIImage(named: img)
            let imgV = UIImageView(image: image,
                                   highlightedImage: checkStringAvailable(highlightedImg) ? UIImage(named: highlightedImg!) : nil)
            imageView = imgV
            if let tint = tintColor {
                imgV.tintColor = tint
                imgV.image = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
            
            if let size = size {
                imgV.snp.makeConstraints { (make) in
                    make.size.equalTo(size)
                }
            }
            if let mode = contentMode {
                imgV.contentMode = mode
            }
            
            config?(imgV)
            return ViewWrapper(imgV, priority)
            
            
        case let .web(url, size, placeholder):
            let imgV = UIImageView()
            imageView = imgV
            imgV.snp.makeConstraints { (make) in
                make.size.equalTo(size)
            }
            imgV.kf.setImage(with: URL(string: url),
                             placeholder: checkStringAvailable(placeholder) ? UIImage(named: placeholder!) : nil,
                             options: nil,
                             progressBlock: nil,
                             completionHandler: nil)
            
            if let mode = contentMode {
                imgV.contentMode = mode
            }
            config?(imgV)
            return ViewWrapper(imgV, priority)
        }
    }
}
