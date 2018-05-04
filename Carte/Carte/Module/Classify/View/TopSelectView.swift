//
//  TopSelectView.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/4.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit

protocol TopSelectViewDelegate: class {
    func selectItem(_ type: TopSelectView.SelectType)
}

class TopSelectView: UIView {
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var salesButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    
    enum SelectType {
        case defaultSelect
        case sales
        case price
    }
    
    var delegate: TopSelectViewDelegate?
    
    func setInitialIndex(_ index: Int = 0) {
        if index == 0 {
            defaultButton.isSelected = true
        } else if index == 1 {
            salesButton.isSelected = true
        } else {
            priceButton.isSelected = true
        }
    }
    
    @IBAction func defaultButtonTap(_ sender: Any) {
        defaultButton.isSelected = true
        salesButton.isSelected = false
        priceButton.isSelected = false
        delegate?.selectItem(.defaultSelect)
    }
    @IBAction func salesButtonTap(_ sender: Any) {
        defaultButton.isSelected = false
        salesButton.isSelected = true
        priceButton.isSelected = false
        delegate?.selectItem(.sales)
    }
    
    @IBAction func priceButtonTap(_ sender: Any) {
        defaultButton.isSelected = false
        salesButton.isSelected = false
        priceButton.isSelected = true
        delegate?.selectItem(.price)
    }
    
}
