//
//  Optional+Extension.swift
//  creams
//
//  Created by Jahov on 06/11/2017.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    
    func removingWhitespaces() -> String? {
        guard let wrapped = self else {
            return nil
        }
        
        let string = wrapped.removingWhitespaces()
        
        guard string != "" else {
            return nil
        }
        
        return string
    }
    
    var isNilOrEmpty: Bool {
        return (self ?? "").isEmpty
    }
}


extension Optional where Wrapped == Array<Any> {
    var isNilOrEmpty: Bool {
        guard let array = self else {
            return true
        }
        if array.count == 0 {
            return true
        }
        return false
    }
}
