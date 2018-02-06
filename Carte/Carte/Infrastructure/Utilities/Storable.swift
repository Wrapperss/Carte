//
//  Storable.swift
//  CreamsAgent
//
//  Created by Rawlings on 15/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation

// MARK: - KeyStorable

private var objectIdentifierKey: UInt8 = 0

protocol KeyStorable: AssociatedObjectStore {}
extension KeyStorable {
    
    private var defaultStoredKey: AnyHashable {
        return "defaultStoredKey"
    }
    
    private var storedKey: AnyHashable {
        return associatedObject(forKey: &objectIdentifierKey, default: defaultStoredKey)
    }
    
    func setStoredKey(_ newValue: AnyHashable) {
        setAssociatedObject(newValue, forKey: &objectIdentifierKey)
    }
    
    func keyEqual(to: KeyStorable) -> Bool {
        assert(storedKey != defaultStoredKey || to.storedKey != defaultStoredKey, "their 'storeKey' has not be configed")
        return storedKey == to.storedKey
    }
    
    func keyEqual(to: AnyHashable) -> Bool {
        return storedKey == to
    }
}


// MARK: - ValueStorable

private var storeRepoKey: UInt8 = 0

protocol ValueStorable: AssociatedObjectStore {
    associatedtype StoreKey: Hashable
}
extension ValueStorable {
    
    @discardableResult
    func store(_ value: Any & KeyStorable, for key: StoreKey) -> Any {
        judgeAssociatedtype(key)
        var storeRepo = associatedObject(forKey: &storeRepoKey, default: [StoreKey: Any]())
        storeRepo[key] = value
        setAssociatedObject(storeRepo, forKey: &storeRepoKey)
        
        value.setStoredKey(key)
        return value
    }
    
    func getStored<T>(_ key: StoreKey) -> T? {
        let storeRepo = associatedObject(forKey: &storeRepoKey, default: [StoreKey: Any]())
        return storeRepo[key] as? T
    }
    
    func getStored<T>(_ keys: [StoreKey]) -> [T] {
        return keys
            .map { getStored($0) }
            .flatMap {$0}
    }
    
    private func judgeAssociatedtype(_ key: StoreKey) {
        assert(Mirror(reflecting: key).displayStyle == .`enum`, "associatedtype is designed to be enumeration type")
    }
}

