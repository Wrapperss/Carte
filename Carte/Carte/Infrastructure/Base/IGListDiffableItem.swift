//
//  ListDiffableItem.swift
//  creams
//
//  Created by hasayakey on 06/03/2017.
//  Copyright © 2017 jiangren. All rights reserved.
//

import IGListKit

class NormalDiffableItem: ListDiffable, Equatable, KeyStorable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return object === self
    }
    
    static func ==(lhs: NormalDiffableItem, rhs: NormalDiffableItem) -> Bool {
        return lhs.isEqual(toDiffableObject: rhs)
    }
}

extension Array where Element == NormalDiffableItem {
    
    @discardableResult
    mutating func separate(by maker: ()->(NormalDiffableItem)) -> [NormalDiffableItem] {
        let originCount = count
        for i in 0..<originCount {
            let toInsert = originCount - 1 - i
            if toInsert != 0 {
                self.insert(maker(), at: toInsert)
            }
        }
        return self
    }
}


final class WrapperDiffableItem<T>: NormalDiffableItem {
    
    let data: T
    
    init(data: T) {
        self.data = data
        super.init()
    }
}


final class IndexDiffableItem<T>: ListDiffable {

    var index: Int
    var item: T

    init(index: Int, item: T) {
        self.index = index
        self.item = item
    }

    func diffIdentifier() -> NSObjectProtocol {
        return self as! NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return object === self
    }
}
