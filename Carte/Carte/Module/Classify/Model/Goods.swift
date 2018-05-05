//
//  Goods.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/4.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import Unbox

struct Goods: Unboxable {
    
    let brand: String?
    let descriptionField: String?
    let id: Int?
    let name: String?
    let origin: String?
    let originalPrice: Double?
    let price: Double?
    let shelfLife: String?
    let stock: Int?
    let storage: String?
    let unit: String?
    let postage: Double?
    let picture: String?
    let volume: Int?
    let manufacturer: String?
    let type: String?
    let packing: String?
    let feature: String?
    let featurePic: String?
    
    init(unboxer: Unboxer) throws {
        brand = unboxer.unbox(key: "brand")
        descriptionField = unboxer.unbox(key: "description")
        id = unboxer.unbox(key: "id")
        name = unboxer.unbox(key: "name")
        origin = unboxer.unbox(key: "origin")
        originalPrice = unboxer.unbox(key: "original_price")
        price = unboxer.unbox(key: "price")
        shelfLife = unboxer.unbox(key: "shelf_life")
        stock = unboxer.unbox(key: "stock")
        storage = unboxer.unbox(key: "storage")
        unit = unboxer.unbox(key: "unit")
        postage = unboxer.unbox(key: "postage")
        picture = unboxer.unbox(key: "picture")
        volume = unboxer.unbox(key: "volume")
        manufacturer = unboxer.unbox(key: "manufacturer")
        type = unboxer.unbox(key: "type")
        packing = unboxer.unbox(key: "packing")
        feature = unboxer.unbox(key: "feature")
        featurePic = unboxer.unbox(key: "featurePic")
    }
    
}
