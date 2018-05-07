//
//  CartBottomView.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit
import BEMCheckBox

class CartBottomView: UIView {

    @IBOutlet weak var checkButton: BEMCheckBox!
    @IBOutlet weak var allCountLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    func setupUI() {
        checkButton.onFillColor = UIColor.init(r: 251, g: 38, b: 44)
        checkButton.onTintColor = UIColor(r: 251, g: 38, b: 44)
        checkButton.onCheckColor = .white
        checkButton.tintColor = .lightGray
        checkButton.onAnimationType = .fill
        checkButton.offAnimationType = .fill
        
        let line = SeparatorLine.init(position: .top, margin: (0, 0), height: 0.5)
        line.work(with: self)
    }
}
