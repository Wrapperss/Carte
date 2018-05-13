//
//  HomeGoodsCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/13.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeGoodsCellDelegate: class {
    func didSelectGoodsItem(_ goodsId: Int)
}

struct HomeGoodsCellRequired {
    let image: String
    let title: String
    let price: String
    let orginPrice: String
    let goodsId: Int
}

class HomeGoodsCell: UICollectionViewCell {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var priceLabel2: UILabel!
    @IBOutlet weak var orginPriceLabel1: UILabel!
    @IBOutlet weak var orginPriceLabel: UILabel!
    
    var delegate: HomeGoodsCellDelegate?
    
    var model: [HomeGoodsCellRequired]? {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func calculateHeight(title1: String, title2: String) -> CGFloat {
        let height1 = CalculateService.Text.calculateSize(NSAttributedString.attribute(title1, .black, fontSize: 17), CalculateService.Text.Base.width(UIScreen.screenWidth / 2)).height + 260
        let height2 = CalculateService.Text.calculateSize(NSAttributedString.attribute(title2, .black, fontSize: 17), CalculateService.Text.Base.width(UIScreen.screenWidth / 2)).height + 260
        
        return height1 > height2 ? height1 : height2
    }

    @IBAction func firstButtonAction(_ sender: Any) {
        guard let goodsId = model?.first?.goodsId else {
            return
        }
        delegate?.didSelectGoodsItem(goodsId)
    }
    
    @IBAction func secondButtonAction(_ sender: Any) {
        guard let goodsId = model?.last?.goodsId else {
            return
        }
        delegate?.didSelectGoodsItem(goodsId)
    }
    
    private func config() {
        guard let model = model, model.count == 2 else {
            return
        }
        
        imageView1.kf.setImage(with: model.first?.image.imageUrl)
        titleLabel1.text = model.first?.title
        priceLabel1.text = model.first?.price
        orginPriceLabel.text = model.first?.orginPrice
        
        imageView2.kf.setImage(with: model.last?.image.imageUrl)
        titleLabel2.text = model.last?.title
        priceLabel2.text = model.last?.price
        orginPriceLabel.text = model.last?.orginPrice
    }
}
