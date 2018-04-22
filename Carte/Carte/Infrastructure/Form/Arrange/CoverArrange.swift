//
//  CoverArrange.swift
//  CreamsAgent
//
//  Created by Rawlings on 07/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation

struct CoverArrange: Arrangeable {
    
    init() {}
    
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 2)
        
        elements.forEach { (ele) in
            container.addSubview(ele)
        }
        
        elements.first?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        elements.last?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
    }
}
