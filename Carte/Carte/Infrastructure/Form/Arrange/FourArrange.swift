//
//  FourArrange.swift
//  creams
//
//  Created by Rawlings on 05/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation

// MARK: - FourCornerArrange

struct FourArrange: Arrangeable {
    
    var edge: UIEdgeInsets
    var relation: (horizontal: CGFloat, vertital: CGFloat)
    
    
    /// Elements -> (leftTop, rightTop, leftBottom, rightBottom)
    //
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 4)
        
        elements.forEach { (ele) in
            container.addSubview(ele)
        }
        
        elements.first?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(edge.top)
            make.left.equalToSuperview().offset(edge.left)
        })
        
        elements[1].snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(edge.right)
            make.bottom.equalTo(elements.first!.snp.bottom)
            make.left.equalTo(elements.first!.snp.right).offset(relation.horizontal)
        }
        
        elements[2].snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(edge.left)
            make.bottom.equalToSuperview().offset(edge.bottom)
            make.top.equalTo(elements.first!.snp.bottom).offset(relation.vertital)
        }
        
        elements[3].snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(edge.right)
            make.bottom.equalTo(elements[2].snp.bottom)
            make.left.equalTo(elements.first!.snp.right).offset(relation.horizontal)
            make.top.equalTo(elements[1].snp.bottom).offset(relation.vertital)

        }
    }
}



