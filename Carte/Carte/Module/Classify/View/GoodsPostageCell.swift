//
//  GoodsPostageCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit

class GoodsPostageCell: UICollectionViewCell {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var postageLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    var postageString: String? {
        didSet {
            config()
            label1.setLineSpacing(8)
            label2.setLineSpacing(8)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineView.cornerRadius = 5
    }

    private func config() {
        guard let string = postageString else {
            return
        }
        
        postageLabel.text = string
    }
}
