//
//  ArrayExtension.swift
//  creams
//
//  Created by Rawlings on 25/11/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit
import Foundation
import SwiftRichString

extension Array {

    var stringLiteral: String {
        var string = ""
        for (index, element) in self.enumerated() {
            if index == count - 1 {
                string += "\(element)"
            } else {
                string += "\(element),"
            }
        }
        return string
    }

    static func containSameElements<T: Comparable & Hashable>(lhs: [T], rhs: [T]) -> Bool {
        let contained = Set(lhs).intersection(Set(rhs))
        return !contained.isEmpty
    }

}

func checkArrayHasElement(_ array: [Any]?) -> Bool {
    return array != nil && !array!.isEmpty
}

extension Array where Element: NSMutableAttributedString {

    func toAttributedString() -> NSAttributedString {

        var string = NSMutableAttributedString()
        let space = NSAttributedString.attribute(" ", UIColor.clear)

        for (index, element) in self.enumerated() {
            string = string + element
            if index != count - 1 {
                string = string + space
            }
        }

        return string
    }
}

extension Array {
    mutating func mutatingForEach(_ transform:(inout Element) -> ()) {
        for i in 0..<count {
            transform(&self[i])
        }
    }
    
    @discardableResult
    mutating func mutatingMap<T>(_ transform:(inout Element) -> T) -> [T] {
        var store = [T]()
        for i in 0..<count {
            store.append(transform(&self[i]))
        }
        return store
    }
    
    @discardableResult
    mutating func appending(_ newElement: Element) -> [Element] {
        self.append(newElement)
        return self
    }
    
    @discardableResult
    mutating func appending(contentOf: [Element]) -> [Element] {
        self.append(contentsOf: contentOf)
        return self
    }
}

extension Array where Element: Hashable {
    
    func removeDuplicates() -> Array {
        return Array(Set<Element>(self))
    }
}

extension Array where Element: Equatable {
    
    mutating func remove(_ predicate:(Element) -> Bool) {
        let toRemove = filter { (ele) -> Bool in
            return predicate(ele)
        }
        toRemove.forEach { (remove) in
            for i in 0..<count {
                if self[i] == remove {
                    _ = self.remove(at: i)
                    break
                }
            }
        }
    }
}

extension Array where Element: ExpressibleByIntegerLiteral {

    func joined(separator: String = ",") -> String {

        let content = self.flatMap { (integer) -> String? in
            return String(describing: integer)
        }

        return content.joined(separator: separator)
    }
}




extension Sequence {
    func group<GroupingType: Hashable>(by key: (Iterator.Element) -> GroupingType) -> [[Iterator.Element]] {
        var groups: [GroupingType: [Iterator.Element]] = [:]
        var groupsOrder: [GroupingType] = []
        forEach { element in
            let key = key(element)
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
                groupsOrder.append(key)
            }
        }
        return groupsOrder.map { groups[$0]! }
    }
}
