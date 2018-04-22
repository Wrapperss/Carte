//
//  ThreeArrange.swift
//  CreamsAgent
//
//  Created by Rawlings on 31/10/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SnapKit

struct ThreeArrange {
    
    static func left_left_right(alignment: ArrangeCommon.Alignment, spaces: (left1: CGFloat, left2: CGFloat, right: CGFloat)) -> Arrangeable {
        return Leading_leading_trailing_Arrange(ArrangeCommon(.horizontal, alignment), spaces: (spaces.left1, spaces.left2, spaces.right))
    }
    
    static func left_right_right(alignment: ArrangeCommon.Alignment, spaces: (left: CGFloat, right1: CGFloat, right2: CGFloat)) -> Arrangeable {
        return Leading_trailing_trailing_Arrange(ArrangeCommon(.horizontal, alignment), spaces: (spaces.left, spaces.right1, spaces.right2))
    }
    
    static func leftSpacing(alignment: ArrangeCommon.Alignment, spaces: (left1: CGFloat, left2: CGFloat, left3: CGFloat)) -> Arrangeable {
        return Leading_Arrange(ArrangeCommon(.horizontal, alignment), spaces: (spaces.left1, spaces.left2, spaces.left3))
    }
}


private struct Leading_leading_trailing_Arrange: Arrangeable {
    
    let arrangeCommon: ArrangeCommon
    let spaces: (leading1: CGFloat, leading2: CGFloat, trailing: CGFloat)
    
    init(_ arrangeCommon: ArrangeCommon, spaces: (leading1: CGFloat, leading2: CGFloat, trailing: CGFloat)) {
        self.arrangeCommon = arrangeCommon
        self.spaces = spaces
    }
    
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 3)
        
        let left = TwoArrange(arrangeCommon, location: .spacing(style: .leading, spaces: (first: spaces.leading1, last: spaces.leading2)))
        left.arrange(elements: [elements[0], elements[1]], to: container)
        
        let right = OneArrange(arrangeCommon, location: OneArrange.AxisLocation.trailing(spaces.trailing))
        right.arrange(elements: [elements.last!], to: container)
    }
}

private struct Leading_trailing_trailing_Arrange: Arrangeable {
    
    let arrangeCommon: ArrangeCommon
    let spaces: (leading: CGFloat, trailing1: CGFloat, trailing2: CGFloat)
    
    init(_ arrangeCommon: ArrangeCommon, spaces: (leading: CGFloat, trailing1: CGFloat, trailing2: CGFloat)) {
        self.arrangeCommon = arrangeCommon
        self.spaces = spaces
    }
    
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 3)
        
        let right = TwoArrange(arrangeCommon, location: .spacing(style: .trailing, spaces: (first: spaces.trailing1, last: spaces.trailing2)))
        right.arrange(elements: [elements[1], elements[2]], to: container)
        
        let left = OneArrange(arrangeCommon, location: OneArrange.AxisLocation.leading(spaces.leading))
        left.arrange(elements: [elements.first!], to: container)
    }
}

private struct Leading_Arrange: Arrangeable {
    
    let arrangeCommon: ArrangeCommon
    let spaces: (leading1: CGFloat, leading2: CGFloat, leading3: CGFloat)
    
    init(_ arrangeCommon: ArrangeCommon, spaces: (leading1: CGFloat, leading2: CGFloat, leading3: CGFloat)) {
        self.arrangeCommon = arrangeCommon
        self.spaces = spaces
    }
    
    func arrange(elements: [UIView], to container: UIView) {
        assert(elements.count == 3)
        
        let left = TwoArrange(arrangeCommon, location: .spacing(style: .leading, spaces: (first: spaces.leading1, last: spaces.leading2)))
        left.arrange(elements: [elements[0], elements[1]], to: container)
        
        let right = OneArrange(arrangeCommon, location: OneArrange.AxisLocation.leading(spaces.leading3))
        right.arrange(elements: [elements.last!], to: container)
    }
}

