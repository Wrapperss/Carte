//
//  MineViewModel.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class MineViewModel: Reactor {
    
    enum Action {
    }
    
    struct State {
    }
    
    var initialState = State()
    
    func reduce(state: MineViewModel.State, mutation: MineViewModel.Action) -> MineViewModel.State {
        return state
    }
}


