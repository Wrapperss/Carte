//
//  OrderBottomView.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation

protocol OrderBottomViewDelegate: class {
    func payButtonTap()
}

class OrderBottomView: UIView {
    
    @IBOutlet weak var countLabel: UILabel!
    
    var delegate: OrderBottomViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func payButtonClick(_ sender: Any) {
        delegate?.payButtonTap()
    }
}
