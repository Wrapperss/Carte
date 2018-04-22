//
//  CommodityCel.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import BEMCheckBox
import Kingfisher

struct CommodityCellRequired {
    let title: String
    let description: String
    let price: String
    let count: String
    let imageUrl: String
}


class CommodityCell: UICollectionViewCell {

    static let size = CGSize.init(width: UIScreen.screenWidth, height: 120)
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var reduceButton: UIButton!
    @IBOutlet weak var checkButton: BEMCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var model: CommodityCellRequired? {
        didSet {
            config()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    
    func setupUI() {
        plusButton.cornerRadius = 2
        plusButton.layer.borderColor = UIColor.black.cgColor
        plusButton.layer.borderWidth = 1
        
        reduceButton.cornerRadius = 2
        reduceButton.layer.borderColor = UIColor.black.cgColor
        reduceButton.layer.borderWidth = 1
        
        checkButton.onFillColor = UIColor.init(r: 251, g: 38, b: 44)
        checkButton.onTintColor = UIColor(r: 251, g: 38, b: 44)
        checkButton.onCheckColor = .white
        checkButton.tintColor = .lightGray
        checkButton.onAnimationType = .fill
        checkButton.offAnimationType = .fill
    }
    
    func config() {
        guard let model = model else {
            return
        }
        titleLabel.text = model.title
        desLabel.text = model.description
        priceLabel.text = model.price
        countLabel.text = model.count
//        coverImageView.kf.setImage(with: URL(string: model.imageUrl))
    }
}
