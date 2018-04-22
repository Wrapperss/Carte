//
//  RefreshIndicator.swift
//  creams
//
//  Created by hasayakey on 8/21/17.
//  Copyright © 2017 Creams.io. All rights reserved.
//

import MJRefresh

final class RefreshIndicator: MJRefreshHeader {

    let animationView: UIActivityIndicatorView
    let leftEdge: CGFloat

    init (color: UIColor? = nil, leftEdge: CGFloat? = 0) {
        self.leftEdge = leftEdge ?? 0
        self.animationView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                if oldValue == .refreshing {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.animationView.alpha = 0.0
                    }, completion: { (_) in
                        if self.state == .idle {
                            self.animationView.alpha = 1.0
                            self.animationView.stopAnimating()
                        }
                    })
                } else {
                    self.animationView.alpha = 1.0
                    self.animationView.stopAnimating()
                }
                break
            case .pulling:
                self.animationView.alpha = 1.0
                self.animationView.stopAnimating()
                break
            case .refreshing:
                self.animationView.alpha = 1.0
                if !self.animationView.isAnimating {
                    self.animationView.startAnimating()
                }
                break
            default:
                break
            }
        }
    }

    override var pullingPercent: CGFloat {
        didSet {

        }
    }

    override func prepare() {
        super.prepare()
        self.mj_h = 50.0
        addSubview(animationView)
        animationView.hidesWhenStopped = false
        animationView.color = .black
    }

    override func placeSubviews() {
        super.placeSubviews()
        self.animationView.frame = CGRect(x: (self.mj_w - 28.0) / 2.0 - self.leftEdge, y: (self.mj_h - 18.0) / 2.0, width: 18.0, height: 18.0)
    }

    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }

}

final class LoadMoreIndicator: MJRefreshAutoFooter {

    let animationView: UIActivityIndicatorView
    let leftEdge: CGFloat

    init (color: UIColor? = nil, leftEdge: CGFloat? = 0) {
        self.leftEdge = leftEdge ?? 0
        self.animationView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                if oldValue == .refreshing {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.animationView.alpha = 0.0
                    }, completion: { (_) in
                        if self.state == .idle {
                            self.animationView.stopAnimating()
                        }
                    })
                } else {
                    self.animationView.alpha = 0.0
                    self.animationView.stopAnimating()
                }
                break
            case .pulling:

                if oldValue != .noMoreData {
                    self.animationView.alpha = 1.0
                } else {
                    self.animationView.alpha = 0.0
                }
                self.animationView.stopAnimating()
                break
            case .refreshing:

                if oldValue != .noMoreData {
                    self.animationView.alpha = 1.0
                } else {
                    self.animationView.alpha = 0.0
                }
                if !self.animationView.isAnimating {
                    self.animationView.startAnimating()
                }
                break
            case .noMoreData:
                self.animationView.alpha = 0.0
                self.animationView.stopAnimating()
                break
            default:
                break
            }
        }
    }

    override var pullingPercent: CGFloat {
        didSet {

        }
    }

    override func prepare() {
        super.prepare()
        self.mj_h = 50.0
        addSubview(animationView)
        animationView.hidesWhenStopped = false
        animationView.color = .black
    }

    override func placeSubviews() {
        super.placeSubviews()
        self.animationView.frame = CGRect(x: (self.mj_w - 18.0) / 2.0 - self.leftEdge, y: (self.mj_h - 18.0) / 2.0, width: 18.0, height: 18.0)
    }

    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }

}
