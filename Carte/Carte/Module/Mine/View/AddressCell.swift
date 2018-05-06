//
//  AddressCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/6.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit

struct AddressCellRequired {
    var name: String
    var phone: String
    var address: String
    var isDefault: Bool
    
}

class AddressCell: UITableViewCell {

    @IBOutlet weak var addressLabelLeading: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var model: AddressCellRequired? {
        didSet {
            config()
        }
    }
    
    private func config() {
        guard let model = model else {
            return
        }
        
        nameLabel.text = model.name
        phoneLabel.text = model.phone
        addressLabel.text = model.address
        if model.isDefault {
            defaultLabel.text = "[默认]"
            addressLabelLeading.constant = 64
        } else {
            defaultLabel.text = ""
            addressLabelLeading.constant = 20
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
