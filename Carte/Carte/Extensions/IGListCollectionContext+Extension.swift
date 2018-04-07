//
//  ListCollectionContext+Extension.swift
//  CreamsAgent
//
//  Created by hasayakey on 14/04/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import IGListKit

extension ListCollectionContext {

    func dequeue<T: UICollectionViewCell>(of cellClass: T.Type,
                                 for sectionController: ListSectionController,
                                              at index: Int) -> T {

        guard let cell = dequeueReusableCell(of: T.self, for: sectionController, at: index) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    func dequeue<T: UICollectionViewCell>(withNibType nibType: T.Type,
                                        for sectionController: ListSectionController,
                                                     at index: Int) -> T {

        guard let cell = dequeueReusableCell(withNibName: String(nibType), bundle: nil, for: sectionController, at: index) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

}
