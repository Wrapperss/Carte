//
//  CreamsRefreshView.swift
//  CreamsAgent
//
//  Created by Rawlings on 27/07/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import DGActivityIndicatorView

class CreamsRefreshView: UIView, CustomRefreshViewProtocol {
    
    static let shared = CreamsRefreshView(frame: .zero)
    
    var holder = CreamsRefreshHolderView(frame: .zero)
    var loading = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.ballPulse, tintColor: UIColor(gray: 200), size: 40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loading?.alpha = 0
        loading?.contentMode = .scaleAspectFit
        addSubview(loading!)
        loading?.snp.makeConstraints({ (make) in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.center.equalTo(self)
        })
        
        addSubview(holder)
        holder.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        holder.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pullingAnimate(withPercent percent: CGFloat, state: SVPullToRefreshState) {
        var value = percent
        if value > 0 {
            if value < 0.3 {
                value = 0
            }
            loading?.alpha = value
            holder.alpha = value
            holder.update(percent: value)
        }
    }
    
    func loadingAnimate() {
        loading?.startAnimating()
        loading?.alpha = 1
        holder.alpha = 0
    }
    
    func finishAnimate() {
        loading?.stopAnimating()
        UIView.animate(withDuration: 0.1, animations: {
            self.loading?.alpha = 0
            self.holder.alpha = 0
        }) { (finish) in
            self.loading?.alpha = 0
            self.holder.alpha = 0
        }
    }
}


class CreamsRefreshHolderView: UIView {
    
    var points = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0..<3 {
            let point = UIView()
            point.cornerRadius = 5
            point.backgroundColor = UIColor(gray: 200)
            addSubview(point)
            points.append(point)
            point.snp.makeConstraints({ (make) in
                let margin = 16
                let offset = -margin + (margin * i)
                make.centerX.equalTo(self).offset(offset)
                make.centerY.equalTo(self)
                make.width.height.equalTo(10)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(percent: CGFloat) {
        points.forEach { (ele) in
            ele.snp.updateConstraints({ (make) in
                let offset = h/2 * (1 - percent)
                make.centerY.equalTo(self).offset(offset)
            })
        }
//        layoutIfNeeded()
    }
}
