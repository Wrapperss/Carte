//
//  HomeSingelCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/13.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct HomeSingelCellRequired {
    let title: String
    let des: String
    let iamge: String
    let goodsName: String
    let goodsDes: String
    let goodPrice: String
    let goodsOrginPrice: String
}


class HomeSingelCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var goodsDesLabel: UILabel!
    @IBOutlet weak var goodsPrice: UILabel!
    @IBOutlet weak var goodsOrginPrice: UILabel!
    
    
    var model: HomeSingelCellRequired? {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.cornerRadius = 5
    }

    
    private func config() {
        guard let model = model else {
            return
        }
        
        titleLabel.text = model.title
        desLabel.text = model.des
        imageView.kf.setImage(with: model.iamge.imageUrl)
        goodsNameLabel.text = model.goodsName
        goodsDesLabel.text = model.goodsDes
        goodsPrice.text = model.goodPrice
        goodsOrginPrice.text = model.goodsOrginPrice
    }
}
