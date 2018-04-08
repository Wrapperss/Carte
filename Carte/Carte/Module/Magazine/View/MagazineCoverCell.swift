//
//  MagazineCoverCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/8.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Kingfisher

struct MagazineCoverCellRequired {
    let coverImageUrl: String
    let tagText: String
    let title: String
    let author: String
    let dateSteing: String
}

class MagazineCoverCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var model: MagazineCoverCellRequired? {
        didSet {
            config()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config() {
        guard let model = model else {
            return
        }
        
//        coverImageView.kf.setImage(with: model.coverImageUrl.toUrl())
        coverImageView.image = UIImage(named: "cover")
        tagLabel.text = model.tagText
        titleLabel.text = model.title
        authorLabel.text = model.author
        dateLabel.text = model.dateSteing
    }
}
