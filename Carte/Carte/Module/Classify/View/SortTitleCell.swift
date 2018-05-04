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
        backgroundColor = UIColor(r: 244, g: 244, b: 244)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundColor = .white
            redMark.isHidden = false
            titileLabel.font = UIFont.systemFont(ofSize: 17)
        } else {
            backgroundColor = UIColor(r: 244, g: 244, b: 244)
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
