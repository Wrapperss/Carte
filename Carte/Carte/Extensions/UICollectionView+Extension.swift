//
//  UICollectionViewExtension.swift
//  creams
//
//  Created by Rawlings on 23/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit
import XXNibBridge

enum SectionHeadFooterkind: String {
    case header = "UICollectionElementKindSectionHeader"
    case footer = "UICollectionElementKindSectionFooter"
}

extension UICollectionView {

    func registerCellWithNibType(_ aClass: AnyClass) {
        self.registerCellsWithNibTypes([aClass])
    }

    func registerCellsWithNibTypes(_ cellTypes: [AnyClass]) {

        for type in cellTypes where type is UICollectionViewCell.Type {
            let `class` = type as! UICollectionViewCell.Type
            self.register(`class`.nib(), forCellWithReuseIdentifier: `class`.reuseIdentifier)
        }
    }

    func registerReuseViewWithNibType(_ viewType: AnyClass, kind: SectionHeadFooterkind) {
        self.registerReuseViewsWithNibTypes([viewType], kind: kind)
    }

    func registerReuseViewsWithNibTypes(_ viewTypes: [AnyClass], kind: SectionHeadFooterkind) {
        for aClass in viewTypes {
            if aClass is UICollectionReusableView.Type {
                let cellClass = aClass as! UICollectionReusableView.Type
                self.register(cellClass.nib(), forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: cellClass.reuseIdentifier)
                continue
            }
            print("\(String(aClass)) is not UICollectionReusableView")
        }
    }

    func deselectAll() {
        for indexPath in self.indexPathsForSelectedItems! {
            self.deselectItem(at: indexPath, animated: true)
        }
    }

    func scrollToBottom() {
        let section = self.numberOfSections - 1
        let item = self.numberOfItems(inSection: section) - 1
        let indexPath = IndexPath(item: item, section: section)
        self.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
}

extension UICollectionView {

    func register<T: UICollectionViewCell>(nib: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UICollectionViewCell>(class: T.Type) {
        register(`class`, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeue<T: UICollectionViewCell>(_ cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
