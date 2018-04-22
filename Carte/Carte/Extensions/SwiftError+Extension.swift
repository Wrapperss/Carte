//
//  SwiftError+Extension.swift
//  creams
//
//  Created by hasayakey on 9/5/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Foundation

extension Error {

    func showHUD() {

        if self is RequestError {
            switch (self as! RequestError) {
            case .statusCode( _, let error):
                HUD.showError(error)
            default :
                HUD.showError((self as! RequestError).message)
            }
        }
    }

}
