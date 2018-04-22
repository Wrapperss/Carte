//
//  ArrangeUtil.swift
//  CreamsAgent
//
//  Created by Rawlings on 01/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SnapKit


//// MARK: - RelationRequired
//
//protocol RelationRequired {
//    var relation: Relation { get set }
//}

/// 两者之间的间距
enum Relation {
    case greaterThanOrEqualTo(CGFloat)
    case lessThanOrEqualTo(CGFloat)
    case equalTo(CGFloat)
    case none
    
    func work(_ targets: (fore: ViewWrapper, after: ViewWrapper), direction: ArrangeCommon.Direction) {
        
        let fr = targets.fore.view
        
        targets.after.view.snp.makeConstraints { (make) in
            switch direction {
            case .horizontal:
                switch self {
                case .greaterThanOrEqualTo(let v):
                    make.left.greaterThanOrEqualTo(fr.snp.right).offset(v)
                    
                case .lessThanOrEqualTo(let v):
                    make.left.lessThanOrEqualTo(fr.snp.right).offset(v)
                    
                case .equalTo(let v):
                    make.left.equalTo(fr.snp.right).offset(v)
                    
                case .none:
                    break
                }
                
            case .vertical:
                switch self {
                case .greaterThanOrEqualTo(let v):
                    make.top.greaterThanOrEqualTo(fr.snp.bottom).offset(v)
                    
                case .lessThanOrEqualTo(let v):
                    make.top.lessThanOrEqualTo(fr.snp.bottom).offset(v)
                    
                case .equalTo(let v):
                    make.top.equalTo(fr.snp.bottom).offset(v)
                    
                case .none:
                    break
                }
            }
        }
    }
}


protocol ArrangeTransition {
    
}

// MARK: - Arrangeable

protocol Arrangeable {
    // Required
    func arrange(elements: [UIView], to container: UIView)
    // Optional
    func arrange(elements: [ViewWrapper], to container: UIView)
}

extension Arrangeable {
    func arrange(elements: [ViewWrapper], to container: UIView) {
        arrange(elements: elements.map { $0.view }, to: container)
    }
}

// MARK: - ArrangeCommon

struct ArrangeCommon {
    let direction: Direction
    let alignment: Alignment
    
    init(_ direction: Direction, _ alignment: Alignment) {
        self.direction = direction
        self.alignment = alignment
    }
    
    func handle(elements: [UIView]) {
        
        elements.forEach { (ele) in
            assert(ele.superview != nil, "add to superview first")
            ele.snp.makeConstraints({ (make) in
                alignment.handle(make, direction: direction)
            })
        }
    }
    
    
    enum Direction {
        case horizontal
        case vertical
        
        var another: Direction {
            switch self {
            case .horizontal:
                return .vertical
            case .vertical:
                return .horizontal
            }
        }
    }
    
    enum Alignment {
        case leading(CGFloat)
        case center
        case trailing(CGFloat)
        case fill(CGFloat, CGFloat)
        
        fileprivate func handle(_ make: ConstraintMaker, direction: Direction) {
            
            let isHorizontal = direction == .horizontal
            
            switch self {
            case .leading(let v):
                _ = isHorizontal ?
                    make.top.equalTo(v) :
                    make.left.equalTo(v)
            case .center:
                _ = isHorizontal ?
                    make.centerY.equalToSuperview() :
                    make.centerX.equalToSuperview()
            case .trailing(let v):
                _ = isHorizontal ?
                    make.bottom.equalTo(-v) :
                    make.right.equalTo(-v)
            case let .fill(leading, trailing):
                if isHorizontal {
                    make.top.equalTo(leading)
                    make.bottom.equalTo(-trailing)
                } else {
                    make.left.equalTo(leading)
                    make.right.equalTo(-trailing)
                }
            }
        }
    }
    
}
