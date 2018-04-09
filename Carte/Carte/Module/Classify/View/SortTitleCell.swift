//
//  SortTitleCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit

struct SortTitleCellRequired {
    let title: String
}

class SortTitleCell: UITableViewCell {

    @IBOutlet weak var redMark: UIView!
    
    @IBOutlet weak var titileLabel: UILabel!
    
    var model: SortTitleCellRequired? {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        redMark.isHidden = false
        backgroundColor = UIColor(244, 244, 244, 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            backgroundColor = .white
            redMark.isHidden = false
            titileLabel.font = UIFont.systemFont(ofSize: 17)
        } else {
            backgroundColor = UIColor(244, 244, 244, 1)
            redMark.isHidden = true
            titileLabel.font = UIFont.systemFont(ofSize: 14)
        }
    }
    
    private func config() {
        guard let model = model else {
            return
        }
        titileLabel.text = model.title
    }
}
