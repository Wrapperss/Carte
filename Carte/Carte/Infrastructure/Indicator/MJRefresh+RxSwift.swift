//
//  MJRefresh+RxSwift.swift
//  creams
//
//  Created by hasayakey on 8/25/17.
//  Copyright © 2017 creams.io. All rights reserved.
//

import RxSwift
import RxCocoa
import MJRefresh

public extension Reactive where Base: MJRefreshComponent {

    public var componentRefresh: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.executeRefreshingCallback)).map { _ in }
        return ControlEvent(events: source)
    }
}
