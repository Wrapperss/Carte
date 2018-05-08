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
    
    @IBOutlet weak var imageToTop: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    
    enum Shap {
        case cover
        case content
    }
    
    var shap: Shap = Shap.cover {
        didSet {
            switch shap {
            case .cover:
                imageToTop.constant = 51
                titleLabel.isHidden = false
                moreLabel.isHidden = false
            case .content:
                imageToTop.constant = 10
                titleLabel.isHidden = true
                moreLabel.isHidden = true
            }
        }
    }
    
    var model: GoodsCommentCoverCellRequired? {
        didSet {
            config()
        }
    }
    
    static func calculateHeight(content: String, shap: Shap) -> CGFloat {
        let height =  CalculateService.Text.calculateSize(NSAttributedString.attribute(content, .black, fontSize: 17),
                                                          CalculateService.Text.Base.width(UIScreen.screenWidth - 30)).height
        switch shap {
        case .cover:
            return height + 130
        case .content:
            return height + 90
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
