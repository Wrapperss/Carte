//
//  GridArrange.swift
//  creams
//
//  Created by Rawlings on 18/01/2018.
//  Copyright © 2018 creams.io. All rights reserved.
//

import Foundation
import SnapKit


class WidthFittingViewWrapper: ViewWrapper {
    
    enum Width {
        case calculateReference(CGFloat)
        case unitNumber(Int)
    }
    
    typealias CalculateHeightByGivenWidth = (_ fittingWidth: CGFloat)->(CGFloat)
    
    var width: Width
    var calculateHeightByGivenWidth: CalculateHeightByGivenWidth
    fileprivate var sizeConstraint: Constraint?
    
    init(view: UIView, width: Width, calculateHeightByGivenWidth: @escaping CalculateHeightByGivenWidth) {
        self.width = width
        self.calculateHeightByGivenWidth = calculateHeightByGivenWidth
        super.init(view)
    }
}


class GridArrange: Arrangeable {
    
    struct Config {
        var containerWidth: CGFloat
        var edge: UIEdgeInsets = UIService.Grid.edge
        var spaceHorizontal: CGFloat = UIService.Grid.spaceHorizontal
        var spaceVertical: CGFloat = UIService.Grid.spaceVertical.greater
        var intrinsicSizeNeeded: Bool = true
        var contentWidth: CGFloat { return containerWidth - edge.left - edge.right }
        
        init(containerWidth: CGFloat) {
            self.containerWidth = containerWidth
        }
    }
    
    private let config: Config
    private var verticalWrapperViews = [UIView]()
    private var innerContainerView: UIView?
    private var layoutFittingSize: CGSize?
    
    init(config: Config) {
        self.config = config
    }
    
    func fittingSize(elements: [Element]) -> CGSize {
        guard layoutFittingSize == nil else {
            return layoutFittingSize!
        }
        let temp = UIView()
        arrange(elements: elements.map { $0.generateViewWrapper() }, to: temp)
        innerContainerView = temp
        layoutFittingSize = innerContainerView!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return layoutFittingSize!
    }
    
    func arrange(elements: [ViewWrapper], to container: UIView) {
        
        guard innerContainerView == nil else {
            container.addSubview(innerContainerView!)
            innerContainerView?.snp.makeConstraints({ (mk) in
                mk.left.top.equalToSuperview()
            })
            return
        }
        
        if let viewWrappers = elements as? [WidthFittingViewWrapper] {
            
            viewWrappers.forEach { container.addSubview($0.view) }
            
            var accumulatedElements = [WidthFittingViewWrapper]()
            var accumulatedWidth: CGFloat = 0
            
            viewWrappers.enumerated().forEach { (index, ele) in
                var fittingW: CGFloat
                switch ele.width {
                case .calculateReference(let refW):
                    fittingW = UIService.Grid.threeLayoutRule(contentWidth: refW,
                                                              totalWidth: config.contentWidth,
                                                              horizontalSpace: config.spaceHorizontal)
                case .unitNumber(let count):
                    assert(count >= 1 && count <= 3, "只支持三单元布局")
                    fittingW = (config.contentWidth + config.spaceHorizontal) / 3 * CGFloat(count) - config.spaceHorizontal
                }
                
                let fittingH = ele.calculateHeightByGivenWidth(fittingW)
                
                ele.view.snp.remakeConstraints({ (mk) in
                    ele.sizeConstraint = mk.size.equalTo(CGSize(width: fittingW, height: fittingH)).constraint
                })
                
                accumulatedWidth += fittingW + config.spaceHorizontal
                
                let diff = round(accumulatedWidth - config.spaceHorizontal - config.contentWidth)
                
                if diff > 0 {
                    horizontalArrange(accumulatedElements)
                    accumulatedElements.removeAll()
                    accumulatedElements.append(ele)
                    accumulatedWidth = fittingW + config.spaceHorizontal
                    if index == viewWrappers.count - 1 {
                        horizontalArrange(accumulatedElements)
                        accumulatedElements.removeAll()
                        accumulatedWidth = 0
                    }
                    
                } else if diff == 0 {
                    accumulatedElements.append(ele)
                    horizontalArrange(accumulatedElements)
                    accumulatedElements.removeAll()
                    accumulatedWidth = 0
                    
                } else if diff < 0 {
                    accumulatedElements.append(ele)
                    if index == viewWrappers.count - 1 {
                        horizontalArrange(accumulatedElements)
                        accumulatedElements.removeAll()
                        accumulatedWidth = 0
                    }
                }
            }
            
            let location: StackArrange.Location
            if config.intrinsicSizeNeeded {
                container.snp.makeConstraints({ (mk) in
                    mk.width.equalTo(config.containerWidth)
                })
                location = StackArrange.Location.fill(config.edge.top, config.edge.bottom)
            } else {
                location = StackArrange.Location.leading(config.edge.top)
            }
            let stackVertical = StackArrange(ArrangeCommon(.vertical, .fill(config.edge.left, config.edge.right)),
                                             location: location,
                                             space: config.spaceVertical)
            
            stackVertical.arrange(elements: verticalWrapperViews, to: container)
            
        } else {
            arrange(elements: elements.map { $0.view }, to: container)
        }
    }
    
    func arrange(elements: [UIView], to container: UIView) {
        fatalError("must work with element which is 'WidthFittingViewWrapper' type")
    }
    
    
    
    private func horizontalArrange(_ eles: [WidthFittingViewWrapper]) {
        let wrapperView = UIView()
        
        let stackHorizontal = StackArrange(ArrangeCommon(.horizontal, .leading(0)),
                                           location: StackArrange.Location.leading(0),
                                           space: config.spaceHorizontal)
        
        stackHorizontal.arrange(elements: eles, to: wrapperView)
        
        let maxH = eles
            .flatMap { $0.sizeConstraint?.layoutConstraints }
            .flatMap { $0 }
            .filter { $0.firstAttribute == NSLayoutAttribute.height }
            .reduce(CGFloat(0)) { max($0.0, $0.1.constant) }
        
        wrapperView.snp.makeConstraints { (mk) in
            mk.height.equalTo(maxH)
        }
        
        verticalWrapperViews.append(wrapperView)
    }
}




