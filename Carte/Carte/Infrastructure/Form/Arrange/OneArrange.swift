//
//  OneArrange.swift
//  CreamsAgent
//
//  Created by Rawlings on 31/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SnapKit

struct OneArrange: Arrangeable {
    
    let arrangeCommon: ArrangeCommon
    let location: AxisLocation
    
    init(_ arrangeCommon: ArrangeCommon, location: AxisLocation) {
        self.arrangeCommon = arrangeCommon
        self.location = location
    }
    
    init(location: (horizontal: AxisLocation, vertical: AxisLocation)) {
        self.init(ArrangeCommon(.horizontal, location.vertical.toAlignment),
                  location: location.horizontal)
    }
    
    init(edgeInsets edge: UIEdgeInsets) {
        self.init(location: (.fill(edge.left, edge.right), .fill(edge.top, edge.bottom)))
    }
    
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 1)
        guard let view = elements.first else {
            return
        }
        container.addSubview(view)
        arrangeCommon.handle(elements: elements)
        
        view.snp.makeConstraints { (make) in
            location.handle(make, direction: arrangeCommon.direction)
        }
    }
    
    
    enum AxisLocation {
        case leading(CGFloat)
        case center
        case trailing(CGFloat)
        case fill(CGFloat, CGFloat)
        
        fileprivate func handle(_ make: ConstraintMaker, direction: ArrangeCommon.Direction) {
            
            let isHorizontal = direction == .horizontal
            
            switch self {
            case .leading(let v):
                _ = isHorizontal ?
                    make.left.equalTo(v) :
                    make.top.equalTo(v)
            case .center:
                _ = isHorizontal ?
                    make.centerX.equalToSuperview() :
                    make.centerY.equalToSuperview()
            case .trailing(let v):
                _ = isHorizontal ?
                    make.right.equalTo(-v) :
                    make.bottom.equalTo(-v)
            case let .fill(leading, trailing):
                if isHorizontal {
                    make.left.equalTo(leading)
                    make.right.equalTo(-trailing)
                } else {
                    make.top.equalTo(leading)
                    make.bottom.equalTo(-trailing)
                }
            }
        }
        
        var toAlignment: ArrangeCommon.Alignment {
            switch self {
            case .leading(let v):
                return ArrangeCommon.Alignment.leading(v)
            case .center:
                return ArrangeCommon.Alignment.center
            case .trailing(let v):
                return ArrangeCommon.Alignment.trailing(v)
            case let .fill(leading, trailing):
                return ArrangeCommon.Alignment.fill(leading, trailing)
            }
        }
    }
}

