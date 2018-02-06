//
//  Associate.swift
//  creams
//
//  Created by Rawlings on 21/12/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import Foundation

//final class ObjectWrapping<T> {
//    let value: T
//    init(_ value: T) {
//        self.value = value
//    }
//}
//
//func setAssociatedObject<T>(object: AnyObject, value: T, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
//    if value is AnyObject.Type {
//        objc_setAssociatedObject(object, associativeKey, value, policy)
//    } else {
//        objc_setAssociatedObject(object, associativeKey, ObjectWrapping(value), policy)
//    }
//}
//
//func getAssociatedObject<T>(object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
//    if let v = objc_getAssociatedObject(object, associativeKey) as? T {
//        return v
//    } else if let v = objc_getAssociatedObject(object, associativeKey) as? ObjectWrapping<T> {
//        return v.value
//    } else {
//        return nil
//    }
//}


import ObjectiveC

public protocol AssociatedObjectStore {
}

extension AssociatedObjectStore {
    func associatedObject<T>(forKey key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }
    
    func associatedObject<T>(forKey key: UnsafeRawPointer, default: @autoclosure () -> T) -> T {
        if let object: T = self.associatedObject(forKey: key) {
            return object
        }
        let object = `default`()
        self.setAssociatedObject(object, forKey: key)
        return object
    }
    
    func setAssociatedObject<T>(_ object: T?, forKey key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
