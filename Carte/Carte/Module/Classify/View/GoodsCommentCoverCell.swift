//
//  GoodsCommentCoverCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit

struct GoodsCommentCoverCellRequired {
    let userName: String
    let scoreString: String
    let content: String
}

class GoodsCommentCoverCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var model: GoodsCommentCoverCellRequired? {
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
        
        nameLabel.text = model.userName
        sourceLabel.text = model.scoreString
        contentLabel.text = model.content
    }
}
