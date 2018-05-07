//
//  CartBottomView.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol CartBottomViewDelegate: class {
    func redButtonTap()
    func didTapCheckButton(isOn: Bool)
}

class CartBottomView: UIView {
    
    enum State {
        case buy
        case edit
    }

    @IBOutlet weak var checkButton: BEMCheckBox!
    @IBOutlet weak var allCountLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var delegate: CartBottomViewDelegate?
    
    var currentState: State = State.buy {
        didSet {
            switch currentState {
            case .buy:
                allCountLabel.isHidden = false
                buyButton.setTitle("结算", for: .normal)
            case .edit:
                allCountLabel.isHidden = true
                buyButton.setTitle("删除", for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
        checkButton.delegate = self
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
    
    
    @IBAction func buttomTap(_ sender: Any) {
        delegate?.redButtonTap()
    }
}

extension CartBottomView: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        delegate?.didTapCheckButton(isOn: checkBox.on)
    }
}
