//
//  CollectionResponseModel.swift
//  creams
//
//  Created by hasayakey on 9/3/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Unbox

public struct CollectionResponse<T: Unboxable>: Unboxable {

    let items: [T]
    let totalCount: Int

    public init(unboxer: Unboxer) throws {
        items = try unboxer.unbox(key: "items")
        totalCount = try unboxer.unbox(key: "totalCount")
    }
}
