//
//  ViewElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 30/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation

class ViewElement: Element {
    
    var view: UIView?
    let size: CGSize
    var color: UIColor {
        didSet{
            view?.backgroundColor = color
        }
    }
    let config: ((UIView)->())?
    
    init(size: CGSize, color: UIColor = UIColor.whiteTwo, config: ((UIView)->())? = nil) {
        self.size = size
        self.color = color
        self.config = config
    }
    
    func generateViewWrapper() -> ViewWrapper {
        if view == nil {
            view = UIView()
        }
        view!.backgroundColor = color
        view!.snp.makeConstraints { (make) in
            make.size.equalTo(size)
        }
        config?(view!)
        return ViewWrapper(view!)
    }
}
