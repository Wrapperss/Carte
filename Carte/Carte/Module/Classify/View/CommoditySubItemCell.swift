//
//  CommoditySubItemCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/3.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct CommoditySubItemCellRequired {
    let cover: String
    let title: String
}

class CommoditySubItemCell: UICollectionViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: CommoditySubItemCellRequired? {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImage.cornerRadius = 5
        backgroundColor = .red
    }
    
    
    private func config() {
        guard let model = model else {
            return
        }
        coverImage.kf.setImage(with: URL(string: "\(Constants.APIKey.serverURL)\(model.cover)"))
        titleLabel.text = model.title
    }
    
}
