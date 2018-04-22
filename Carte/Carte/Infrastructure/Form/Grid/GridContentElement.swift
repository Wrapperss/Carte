//
//  GridContentElement.swift
//  creams
//
//  Created by shying li on 2018/1/16.
//  Copyright © 2018年 creams.io. All rights reserved.
//

import Foundation


class GridPairElement: Element {
    
    /// Width Type
    ///
    /// - calculate: 根据内容自动计算
    /// - ratio: 单元个数(1, 2, 3)
    enum Width {
        case calculate
        case ratio(Int)
    }
    
    enum LineStyle {
        case single
        case multi
    }
    
    var width: Width
    var lineStyle: LineStyle
    var pair: GridUnitData
    var pairView: UIView?
    
    init(_ pair: GridUnitData, width: Width = .calculate, lineStyle: LineStyle = .single) {
        self.pair = pair
        self.width = width
        self.lineStyle = lineStyle
    }
    
    func generateViewWrapper() -> ViewWrapper {
        let numberOfLines = lineStyle == .single ? 1 : 0
        let eles = [TextElement(text: pair.attrTitle, config: { $0.numberOfLines = numberOfLines }),
                    TextElement(text: pair.attrContent, config: { $0.numberOfLines = numberOfLines })]
        let wra = WrapperElement(elements: eles,
                                 arrange: TwoArrange.Vertical.siding(0, .fill(0, 0)),
                                 size: .zero)

        pairView = wra.generateViewWrapper().view
        
        let w: WidthFittingViewWrapper.Width
        switch self.width {
        case .ratio(let count):
            w = WidthFittingViewWrapper.Width.unitNumber(count)
        default:
            let widths = eles.map { $0.text.calculateSize(CalculateService.Text.Base.singleLine).width }
            let referenceWidth = widths.reduce(CGFloat(0)) { max($0.0, $0.1) }
            w = WidthFittingViewWrapper.Width.calculateReference(referenceWidth)
        }
        
        return WidthFittingViewWrapper(view: pairView!,
                                       width: w,
                                       calculateHeightByGivenWidth: { [unowned self] (fittingWidth) -> (CGFloat) in
                                        eles.reduce(UIService.Grid.spaceVertical.small, {
                                            if self.lineStyle == .single {
                                                return $0.0 + $0.1.text.calculateSize(CalculateService.Text.Base.singleLine).height
                                            } else {
                                                return $0.0 + $0.1.text.calculateSize(CalculateService.Text.Base.width(fittingWidth)).height
                                            }
                                        })
        })
    }
    
}


class GridContentFormItem: FormItem {
    
    var elements: [GridPairElement]
    
    init(elements: [GridPairElement], width: CGFloat, config: FormItemConfig) {
        self.elements = elements
        
        let arrange = GridArrange(config: GridArrange.Config(containerWidth: width))
        
        let box = FormLayoutBox(elements: elements,
                                arrange: arrange,
                                size: arrange.fittingSize(elements: elements))
        super.init(box: box, config: config)
    }
    
    convenience init(data: [GridUnitData], width: CGFloat, separator: SeparatorLine? = SeparatorLine()) {
        var config = FormItemConfig()
        config.separatorLine = separator
        let elements = data.map { GridPairElement($0) }
        self.init(elements: elements, width: width, config: config)
    }
}
