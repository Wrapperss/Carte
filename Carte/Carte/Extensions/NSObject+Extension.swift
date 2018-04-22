//
//  NSObject+Extension.swift
//  creams
//
//  Created by Rawlings on 16/08/2017.
//  Copyright © 2017 Creams.io. All rights reserved.
//

import Foundation

extension NSObject {

    static var className: String {
        return String(describing: self)
    }

    static var typeWithNamespace: String {
        return String(reflecting: self)
    }

    var typeWithNamespace: String {
        return String(reflecting: type(of: self))
    }
}
