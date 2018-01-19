//
//  Logger.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/1/19.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = Logger().log

class Logger {
    
    let log = SwiftyBeaver.self
    
    init() {
        let console = ConsoleDestination()
        self.log.addDestination(console)
        let file = FileDestination()
        self.log.addDestination(file)
    }
}
