//
//  HomeCategoaryCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct HomeCategoaryCellRequired {
    let title: String
    let decription: String
    let image: String
}

class HomeCategoaryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: HomeCategoaryCellRequired? {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.cornerRadius = 5
        imageView.shadowRadius = 5
    }
    

    private func config() {
        guard let model = model else {
            return
        }
        
        imageView.kf.setImage(with: model.image.imageUrl)
        titleLabel.text = model.title
        descriptionLabel.text = model.decription
    }
}
