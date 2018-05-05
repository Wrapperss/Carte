//
//  GoodBanerView.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation

protocol GoodBanerViewDelegate: class {
    func toCart()
    func addCart()
    func toBuy()
}

class GoodBanerView: UIView {
    
    var delegate: GoodBanerViewDelegate?
    
    @IBAction func toCart(_ sender: Any) {
        delegate?.toCart()
    }
    
    @IBAction func addCart(_ sender: Any) {
        delegate?.addCart()
    }
    @IBAction func toBuy(_ sender: Any) {
        delegate?.toBuy()
    }
}
