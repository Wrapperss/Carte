//
//  MineFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

extension DataFactory.viewRequired {
    static func matchAddressCellRequired(_ address: Address) -> AddressCellRequired {
        return AddressCellRequired(name: address.contract ?? "-",
                                   phone: address.phoneNum ?? "-",
                                   address: "\(address.city ?? "-")\(address.detail ?? "-")",
                                   isDefault: address.isDefault == 1 ? true : false)
    }
}

extension DataFactory.sectionItem {
    
}
