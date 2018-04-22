//
//  TwoArrange.swift
//  CreamsAgent
//
//  Created by Rawlings on 31/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SnapKit


extension TwoArrange {
    
    struct Horizontal: TwoArrangeConvenience {
        static var direction: ArrangeCommon.Direction = .horizontal
    }
    
    struct Vertical: TwoArrangeConvenience {
        static var direction: ArrangeCommon.Direction = .vertical
    }
}

protocol TwoArrangeConvenience {
    static var direction: ArrangeCommon.Direction { get }
}

extension TwoArrangeConvenience {
    
    // MARK: - siding
    
    static func siding(_ space: CGFloat, _ alignment: ArrangeCommon.Alignment = .center) -> TwoArrange {
        return siding((space, space), alignment)
    }
    
    static func siding(_ spaces: (CGFloat, CGFloat), _ alignment: ArrangeCommon.Alignment = .center) -> TwoArrange {
        return TwoArrange(ArrangeCommon(direction, alignment),
                          location: .symmetric(style: .siding, spaces: (first: spaces.0, last: spaces.1)))
    }
    
    // MARK: - central
    
    static func central(_ space: CGFloat, _ alignment: ArrangeCommon.Alignment = .center) -> TwoArrange {
        return central((space, space), alignment)
    }
    
    static func central(_ spaces: (CGFloat, CGFloat), _ alignment: ArrangeCommon.Alignment = .center) -> TwoArrange {
        return TwoArrange(ArrangeCommon(direction, alignment),
                          location: .symmetric(style: .central, spaces: (first: spaces.0, last: spaces.1)))
    }
    
    // MARK: - spacing
    
    static func spacingLeading(_ spaces: (CGFloat, CGFloat), _ alignment: ArrangeCommon.Alignment = .center) -> TwoArrange {
        return TwoArrange(ArrangeCommon(direction, alignment),
                          location: .spacing(style: .leading, spaces: (first: spaces.0, last: spaces.1)))
    }
    
    static func spacingTrailing(_ spaces: (CGFloat, CGFloat), _ alignment: ArrangeCommon.Alignment = .center) -> TwoArrange {
        return TwoArrange(ArrangeCommon(direction, alignment),
                          location: .spacing(style: .trailing, spaces: (first: spaces.0, last: spaces.1)))
    }
}





struct TwoArrange: Arrangeable {
    
    var relation: Relation = .none

    let arrangeCommon: ArrangeCommon
    let location: Location
    
    init(_ arrangeCommon: ArrangeCommon, location: Location) {
        self.arrangeCommon = arrangeCommon
        self.location = location
    }
    
    @discardableResult
    func relation(_ relation: Relation) -> TwoArrange {
        var temp = TwoArrange(arrangeCommon, location: location)
        temp.relation = relation
        return temp
    }
    
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 2)
        
        elements.forEach { (ele) in
            container.addSubview(ele)
        }
        arrangeCommon.handle(elements: elements)
        
        elements.first!.snp.makeConstraints { (make) in
            location.handle(make: make, direction: arrangeCommon.direction, container: container, isFirst: true)
        }
        elements.last!.snp.makeConstraints { (make) in
            location.handle(make: make, direction: arrangeCommon.direction, container: container, isFirst: false)
        }
    }
    
    func arrange(elements: [ViewWrapper], to container: UIView) {
        arrange(elements: elements.map { $0.view }, to: container)
        relation.work((elements.first!, elements.last!), direction: arrangeCommon.direction)
    }
    
    
    enum Location {
        case symmetric(style: SymmetricStyle, spaces: (first: CGFloat, last: CGFloat))
        case spacing(style: SpacingRefStyle, spaces: (first: CGFloat, last: CGFloat))
        
        /// 对称方式
        ///
        /// - siding: 两边对称
        /// - central: 中间对称
        enum SymmetricStyle {
            case siding
            case central
        }
        
        /// 参照点的方位 / 从哪边开始排列
        ///
        /// - leading: 参照点在左上
        /// - trailing: 参照点在右下
        enum SpacingRefStyle {
            case leading
            case trailing
        }
        
        func handle(make: ConstraintMaker, direction: ArrangeCommon.Direction, container: UIView, isFirst: Bool) {
            
            switch self {
            case let .symmetric(style, spaces):
                switch style {
                case .siding:
                    switch direction {
                    case .horizontal:
                        _ = isFirst ?
                            make.left.equalTo(spaces.first) :
                            make.right.equalTo(-spaces.last)
                    case .vertical:
                        _ = isFirst ?
                            make.top.equalTo(spaces.first) :
                            make.bottom.equalTo(-spaces.last)
                    }
                case .central:
                    switch direction {
                    case .horizontal:
                        _ = isFirst ?
                            make.right.equalTo(container.snp.centerX).offset(-spaces.first) :
                            make.left.equalTo(container.snp.centerX).offset(spaces.last)
                    case .vertical:
                        _ = isFirst ?
                            make.bottom.equalTo(container.snp.centerY).offset(-spaces.first) :
                            make.top.equalTo(container.snp.centerY).offset(spaces.last)
                    }
                }
                
            case let .spacing(style, spaces):
                switch style {
                case .leading:
                    switch direction {
                    case .horizontal:
                        _ = isFirst ?
                            make.left.equalTo(spaces.first) :
                            make.left.equalTo(spaces.last)
                    case .vertical:
                        _ = isFirst ?
                            make.top.equalTo(spaces.first) :
                            make.top.equalTo(spaces.last)
                    }
                case .trailing:
                    switch direction {
                    case .horizontal:
                        _ = isFirst ?
                            make.right.equalTo(-spaces.first) :
                            make.right.equalTo(-spaces.last)
                    case .vertical:
                        _ = isFirst ?
                            make.bottom.equalTo(-spaces.first) :
                            make.bottom.equalTo(-spaces.last)
                    }
                }
            }
        }
    }
}

