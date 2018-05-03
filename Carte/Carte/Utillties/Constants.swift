//
//  Constants.swift
//  creams
//
//  Created by Jahov on 28/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

struct Constants {
    static let pageLimit: Int = 20
    static let requestDateFormatter = "yyyy-MM-dd"
    
    struct APIKey {
        static var serverURL: String {
            get {
                return "http://127.0.0.1:7002"
            }
        }
    }
}

