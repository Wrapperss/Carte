//
//  OrderCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct OrderCellRequired {
    let coverImage: String
    let title: String
    let description: String
    let priceString: String
}

class OrderCell: UICollectionViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var orderGoods: OrderContent.OrderGoods? {
        didSet {
            fetch()
        }
    }
    
    var model: OrderCellRequired? {
        didSet {
            config()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImage.cornerRadius = 4
    }

    private func config() {
        guard let model = model else {
            return
        }
        coverImage.kf.setImage(with: model.coverImage.imageUrl)
        titleLabel.text = model.title
        decriptionLabel.text = model.description
        priceLabel.text = model.priceString
    }
    
    private func fetch() {
        guard let orderGoods = orderGoods else {
            return
        }
        
        ClassifyAPI
            .fetchGoodsDetail(orderGoods.goodsId ?? 0)
            .then { [weak self] (goods) -> Void in
                self?.model = OrderCellRequired(coverImage: goods.picture ?? "",
                                                title: goods.name ?? "",
                                                description: goods.descriptionField ?? "",
                                                priceString: "￥\(goods.price ?? 0.0) * \(orderGoods.quantity ?? 0)")
            }
            .catch { (_) in
            }
    }
}
