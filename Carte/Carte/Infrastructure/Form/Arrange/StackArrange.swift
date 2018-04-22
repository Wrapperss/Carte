//
//  StackArrange.swift
//  CreamsAgent
//
//  Created by Rawlings on 01/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SnapKit

struct StackArrange: Arrangeable {
    
    let arrangeCommon: ArrangeCommon
    let location: Location
    let spaces: [CGFloat]
    
    var space: CGFloat?
    
    init(_ arrangeCommon: ArrangeCommon, location: Location, space: CGFloat) {
        self.init(arrangeCommon, location: location, spaces: [])
        self.space = space
    }
    
    init(_ arrangeCommon: ArrangeCommon, location: Location, spaces: [CGFloat]) {
        self.arrangeCommon = arrangeCommon
        self.location = location
        self.spaces = spaces
    }
    
    func arrange(elements: [UIView], to container: UIView) {
        guard  elements.count > 0 else {
            print("elements 个数为0")
            return
        }
        
        if space == nil {
            assert(spaces.count == elements.count - 1, "spaces 与 elements 数量匹配错误")
        }
        
        elements.forEach { (ele) in
            container.addSubview(ele)
        }
        arrangeCommon.handle(elements: elements)
        
        let sps = space == nil ? spaces : [CGFloat](repeating: space!, count: elements.count-1)
        
        handleSpaces(elements: elements, spaces: sps)
        
        location.handle(direction: arrangeCommon.direction, elements: elements, container: container, spaces: sps)
    }
    
    
    private func handleSpaces(elements: [UIView], spaces: [CGFloat]) {
        assert(spaces.count == elements.count - 1)
        let isHorizontal = arrangeCommon.direction == .horizontal
        
        for (index, ele) in elements.enumerated() {
            ele.snp.makeConstraints({ (make) in
                if index > 0 {
                    _ = isHorizontal ?
                        make.left.equalTo(elements[index-1].snp.right).offset(spaces[index-1]) :
                        make.top.equalTo(elements[index-1].snp.bottom).offset(spaces[index-1])
                }
            })
        }
    }
    
    
    enum Location {
        case leading(CGFloat)
        case center
        case trailing(CGFloat)
        case fill(CGFloat, CGFloat)
        
        func handle(direction: ArrangeCommon.Direction, elements: [UIView], container: UIView, spaces: [CGFloat]) {
            
            let isHorizontal = direction == .horizontal
            
            switch self {
            case .leading(let head):
                elements.first?.snp.makeConstraints({ (make) in
                    _ = isHorizontal ?
                        make.left.equalToSuperview().offset(head) :
                        make.top.equalToSuperview().offset(head)
                })

            case .trailing(let tail):
                elements.last?.snp.makeConstraints({ (make) in
                    _ = isHorizontal ?
                        make.right.equalToSuperview().offset(-tail) :
                        make.bottom.equalToSuperview().offset(-tail)
                })
                
            case let .fill(head, tail):
                elements.first?.snp.makeConstraints({ (make) in
                    _ = isHorizontal ?
                        make.left.equalToSuperview().offset(head) :
                        make.top.equalToSuperview().offset(head)
                })
                elements.last?.snp.makeConstraints({ (make) in
                    _ = isHorizontal ?
                        make.right.equalTo(container).offset(-tail) :
                        make.bottom.equalTo(container).offset(-tail)
                })
                
            case .center:
                let count = elements.count
                
                guard count > 1 else {
                    elements[0].snp.makeConstraints({ (make) in
                        _ = isHorizontal ?
                            make.centerX.equalToSuperview() :
                            make.centerY.equalToSuperview()
                    })
                    return
                }
                
                if count % 2 == 0 {
                    let offset = spaces[count/2-1]/2
                    elements[count/2-1].snp.makeConstraints({ (make) in
                        _ = isHorizontal ?
                            make.right.equalTo(container.snp.centerX).offset(-offset) :
                            make.bottom.equalTo(container.snp.centerY).offset(-offset)
                    })
                    
                } else {
                    let median = count / 2
                    elements[median].snp.makeConstraints({ (make) in
                        _ = isHorizontal ?
                            make.centerX.equalToSuperview() :
                            make.centerY.equalToSuperview()
                    })
                }
            }
        }
    }
}

