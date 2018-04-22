//
//  IGListAdapter+Extension.swift
//  creams
//
//  Created by hasayakey on 9/30/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import IGListKit

extension ListAdapter {

    /// 因为 mjrefresh 需要根据 reload 方法进行一些操作,但是 performUpdates 不会触发 reload, 所以会有一些问题
    func performUpdates() {
        reloadData(completion: nil)
//        if objects().isEmpty {
//            reloadData(completion: nil)
//        } else {
//            reloadData(completion: nil)
//            performUpdates(animated: true, completion: nil)
//        }
    }
}
