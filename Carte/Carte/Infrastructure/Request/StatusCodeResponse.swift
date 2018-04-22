//
//  StatusCodeResponse.swift
//  creams
//
//  Created by hasayakey on 9/10/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Unbox

public struct StatusCodeResponse: Unboxable {

    let code: Int

    init(code: Int) {
        self.code = code
    }

    public init(unboxer: Unboxer) throws {
        code = try unboxer.unbox(key: "code")
    }
}
