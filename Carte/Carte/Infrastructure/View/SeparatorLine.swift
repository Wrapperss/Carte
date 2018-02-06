//
//  SeparatorLine.swift
//  CreamsAgent
//
//  Created by Rawlings on 20/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import UIKit


protocol SeparatorLineNeeded {
    var separatorLine: SeparatorLine? { get }
}



struct SeparatorLine {
    var position: Position = .bottom
    var margin: (left: CGFloat, right: CGFloat) = (0, 0)
    var height: CGFloat = 0.5
    var color: UIColor = UIColor.whiteTwo
    
    enum Position {
        case top
        case bottom
    }
    
    init(position: Position = .bottom,
         margin: (left: CGFloat, right: CGFloat) = (0, 0),
         height: CGFloat = 0.5,
         color: UIColor = UIColor.whiteTwo)
    {
        self.position = position
        self.margin = margin
        self.height = height
        self.color = color
    }
    
    @discardableResult
    func work(with container: UIView) -> UIView {
        
        let line = UIView(frame: .zero)
        line.backgroundColor = color
        container.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(container).offset(margin.left)
            make.right.equalTo(container).offset(-margin.right)
            make.height.equalTo(height)
            switch position {
            case .bottom:
                make.bottom.equalTo(container)
            case .top:
                make.top.equalTo(container)
            }
        }
        return line
    }
}



extension UIView {
    
    func addSeparatorLine(_ separator: SeparatorLine = SeparatorLine()) {
        separator.work(with: self)
    }
    
}
