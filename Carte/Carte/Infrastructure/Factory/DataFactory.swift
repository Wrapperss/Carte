//
//  DataFactory.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation

//protocol PrepareAble {
//    func prepare<T, E>(Model: E) -> T
//}

struct DataFactory {
    
    //Model => ViewRequired
    struct viewRequired {}
    
    //Model => SectionItem
    struct sectionItem {}

}

//Demo

//extension DataFactory.viewRequired {
//    static func prepare(_ Model: Model_A) -> ViewRequired_A {
//        ....
//    }
//
//    static func prepare(_ Model: Model_B) -> ViewRequired_B {
//        ....
//    }
//}

//extension DataFactory.sectionItem {
//    static func prepare(_ Model: Model_A) -> SectionItem_A {
//        ....
//    }
//
//    static func prepare(_ Model: Model_B) -> SectionItem_B {
//        ....
//    }
//}

