//
//  GoodsCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/4.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct GoodsCellRequired {
    let image: String
    let title: String
    let description: String
    let comment: String
    let price: String
    let orginalPrice: String
    let postage: String
    let goodsId: Int
}

class GoodsCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orginalPriceLabel: UILabel!
    @IBOutlet weak var postageLabel: UILabel!
    
    var model: GoodsCellRequired? {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postageLabel.cornerRadius = 4
    }

    private func config() {
        guard let model = model else {
            return
        }
        
        imageView.kf.setImage(with: model.image.imageUrl)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        priceLabel.text = model.price
        orginalPriceLabel.text = model.orginalPrice
        postageLabel.text = model.postage
    }
}
