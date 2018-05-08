//
//  OrderAdressCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/8.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import UIKit

struct OrderAdressCellRequired {
    let name: String
    let address: String
    let phone: String
}

class OrderAdressCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var model: OrderAdressCellRequired? {
        didSet{
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
        
        nameLabel.text = model.name
        addressLabel.text = model.address
        phoneLabel.text = model.phone
    }
}
