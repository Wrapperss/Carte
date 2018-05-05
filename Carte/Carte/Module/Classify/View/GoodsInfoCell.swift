//
//  GoodsInfoCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit

protocol GoodsInfoCellDelegate: class {
    func moreInfoButtonClick()
}

struct GoodsInfoCellRequired {
    let orgin: String
    let brand: String
    let sheifLife: String
    let storage: String
}

class GoodsInfoCell: UICollectionViewCell {

    @IBOutlet weak var orginLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var shelfLifeLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    var model: GoodsInfoCellRequired? {
        didSet {
            config()
        }
    }
    var delegate: GoodsInfoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineView.cornerRadius = 5
    }

    private func config() {
        guard let model = model else {
            return
        }
        
        orginLabel.text = model.orgin
        brandLabel.text = model.brand
        shelfLifeLabel.text = model.sheifLife
        storageLabel.text = model.storage
    }

    @IBAction func moreInfoButtonTap(_ sender: Any) {
        delegate?.moreInfoButtonClick()
    }
}
