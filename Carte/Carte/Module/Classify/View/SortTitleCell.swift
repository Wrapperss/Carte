//
//  SortTitleCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit

class SortTitleCell: UITableViewCell {

    @IBOutlet weak var redMark: UIView!
    
    @IBOutlet weak var titileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        redMark.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        redMark.isHidden = false
        titileLabel.font = UIFont.systemFont(ofSize: 23, weight: UIFontWeightMedium)
    }
    
}
