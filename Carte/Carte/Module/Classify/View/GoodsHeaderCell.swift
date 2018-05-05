//
//  GoodsHeaderCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct GoodsHeaderCellRequired {
    let iamge: String
    let title: String
    let description: String
    let price: String
    let orginalPrice: String
}

class GoodsHeaderCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orginalPrice: UILabel!
    
    var model: GoodsHeaderCellRequired? {
        didSet {
            config()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func config() {
        guard let model = model else {
            return
        }
        
        coverImageView.kf.setImage(with: model.iamge.imageUrl)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        priceLabel.text = model.price
        orginalPrice.text = model.orginalPrice
    }
}
