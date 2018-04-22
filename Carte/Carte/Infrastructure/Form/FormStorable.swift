//
//  FormStorable.swift
//  CreamsAgent
//
//  Created by Rawlings on 15/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import IGListKit

// MARK: - ElementStorable

private var storeElementsRepoKey: UInt8 = 0

protocol ElementStorable: AssociatedObjectStore {
    associatedtype ElementKey: Hashable
}
extension ElementStorable {
    
    @discardableResult
    func store(for key: ElementKey, _ element: Element & KeyStorable) -> Element {
        return store(element, for: key)
    }
    
    @discardableResult
    func store(_ element: Element & KeyStorable, for key: ElementKey) -> Element {
        judgeAssociatedtype(key)
        
        var storeRepo = associatedObject(forKey: &storeElementsRepoKey, default: defaultStoreValue)
        storeRepo[key] = element
        setAssociatedObject(storeRepo, forKey: &storeElementsRepoKey)
        
        element.setStoredKey(key)
        return element
    }
    
    func getStored<T: Element>(_ key: ElementKey) -> T? {
        let storeRepo = associatedObject(forKey: &storeElementsRepoKey, default: defaultStoreValue)
        return storeRepo[key] as? T
    }
    
    func getStored<T: Element>(_ keys: [ElementKey]) -> [T] {
        return keys
            .map { getStored($0) }
            .flatMap {$0}
    }
    
    private var defaultStoreValue: [ElementKey: Any] {
        return [ElementKey: Any]()
    }
    
    private func judgeAssociatedtype(_ key: ElementKey) {
        assert(Mirror(reflecting: key).displayStyle == .`enum`, "associatedtype is designed to be enumeration type")
    }
}


// MARK: - ListItemStorable

private var storeFormItemsRepoKey: UInt8 = 0

protocol ListItemStorable: AssociatedObjectStore {
    associatedtype ListItemKey: Hashable
}
extension ListItemStorable {
    
    @discardableResult
    func store(for key: ListItemKey, _ listItem: NormalDiffableItem) -> NormalDiffableItem {
        return store(listItem, for: key)
    }
    
    @discardableResult
    func store(_ listItem: NormalDiffableItem, for key: ListItemKey) -> NormalDiffableItem {
        judgeAssociatedtype(key)
        
        var storeRepo = associatedObject(forKey: &storeFormItemsRepoKey, default: defaultStoreValue)
        storeRepo[key] = listItem
        setAssociatedObject(storeRepo, forKey: &storeFormItemsRepoKey)
        
        listItem.setStoredKey(key)
        return listItem
    }
    
    func getStored<T: NormalDiffableItem>(_ key: ListItemKey) -> T? {
        let storeRepo = associatedObject(forKey: &storeFormItemsRepoKey, default: defaultStoreValue)
        return storeRepo[key] as? T
    }
    
    func getStored<T: NormalDiffableItem>(_ keys: [ListItemKey]) -> [T] {
        return keys
            .map { getStored($0) }
            .flatMap {$0}
    }
    
    private var defaultStoreValue: [ListItemKey: Any] {
        return [ListItemKey: Any]()
    }
    
    private func judgeAssociatedtype(_ key: ListItemKey) {
        assert(Mirror(reflecting: key).displayStyle == .`enum`, "associatedtype is designed to be enumeration type")
    }
}
