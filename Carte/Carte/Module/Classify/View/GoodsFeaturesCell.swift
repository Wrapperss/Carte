//
//  GoodsFeaturesCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct GoodsFeaturesCellRequired {
    let content: String
    let image: String
}

class GoodsFeaturesCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var model: GoodsFeaturesCellRequired? {
        didSet {
            config()
            contentLabel.setLineSpacing(5)
        }
    }
    
    static func calculateSize(_ content: String?) -> CGSize {
        guard let content = content else {
            return CGSize.zero
        }
        
        let height = CalculateService.Text.calculateSize(NSAttributedString.attribute(content, .black, fontSize: 17),
                                                         CalculateService.Text.Base.width(UIScreen.screenWidth - 30)).height
        return CGSize(width: UIScreen.screenWidth, height: height + 410)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineView.cornerRadius = 5
    }

    private func config() {
        guard let model = model else {
            return
        }
        contentLabel.text = model.content
        imageView.kf.setImage(with: model.image.imageUrl)
    }
}
