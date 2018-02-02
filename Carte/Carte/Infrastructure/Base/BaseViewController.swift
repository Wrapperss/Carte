//
//  BaseViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/1/19.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import RxSwift
import ChameleonFramework

class BaseViewController: UIViewController {
    
    // MARK: Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARk: Rx
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        log.verbose("DEINIT: \(self.className)")
    }
}
