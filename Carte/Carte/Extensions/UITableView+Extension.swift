//
//  UITableView+Extension.swift
//  creams
//
//  Created by Jahov on 18/10/2017.
//  Copyright © 2017 creams.io. All rights reserved.
//

import Foundation


extension UITableView {
    
    func removeBottomSeparatorLine() {
        tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func registerNib(_ cell: UITableViewCell.Type) {
        register(UINib.init(nibName: cell.className, bundle: nil), forCellReuseIdentifier: cell.className)
    }
    
}
