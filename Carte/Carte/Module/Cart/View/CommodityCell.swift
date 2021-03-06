//
//  CommodityCel.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import BEMCheckBox
import Kingfisher

protocol CommodityCellDelegate: class {
    func deleteCartItem(_ cart: Cart?)
    func checkBoxChange(isAdd: Bool, cart: Cart, goods: Goods)
    func changeCart(cart: Cart, goods: Goods)
}

struct CommodityCellRequired {
    let title: String
    let description: String
    let price: String
    let count: String
    let imageUrl: String
}

class CommodityCell: UICollectionViewCell {

    static let size = CGSize(width: UIScreen.screenWidth, height: 120)
    @IBOutlet weak var reduceButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var checkButton: BEMCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var isFirst: Bool = true
    
    var goods: Goods?
    
    var cart: Cart? {
        didSet {
            if isFirst {
                fetch()
                isFirst = false
            }
        }
    }
    
    var model: CommodityCellRequired? {
        didSet {
            config()
        }
    }
    
    var count: Int = 0 {
        didSet {
            post()
        }
    }
    
    var delegate: CommodityCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
        checkButton.delegate = self
        NotificationCenter.registerNotification(self, #selector(change(notification:)), name: .selectCartItem)
    }
    
    deinit {
        NotificationCenter.remove(self)
    }
    
    func setupUI() {
        plusButton.cornerRadius = 2
        plusButton.layer.borderColor = UIColor.lightGray.cgColor
        plusButton.layer.borderWidth = 1
        
        reduceButton.cornerRadius = 2
        reduceButton.layer.borderColor = UIColor.lightGray.cgColor
        reduceButton.layer.borderWidth = 1
        
        checkButton.onFillColor = UIColor(r: 251, g: 38, b: 44)
        checkButton.onTintColor = UIColor(r: 251, g: 38, b: 44)
        checkButton.onCheckColor = .white
        checkButton.tintColor = .lightGray
        checkButton.onAnimationType = .fill
        checkButton.offAnimationType = .fill
    }
    
    func config() {
        guard let model = model else {
            return
        }
        titleLabel.text = model.title
        desLabel.text = model.description
        priceLabel.text = model.price
        countLabel.text = model.count
        count = Int(model.count) ?? 0
        coverImageView.kf.setImage(with: model.imageUrl.imageUrl)
    }
    
    func fetch() {
        guard let cart = cart else {
            return
        }
        ClassifyAPI
            .fetchGoodsDetail(cart.goodsId ?? 0)
            .then { [weak self] (goods) -> Void in
                NotificationCenter.postNotification(name: .getGoodsDetail, userInfo: ["goods": goods])
                self?.goods = goods
                self?.model = DataFactory.viewRequired.matchCommodityCellRequired(goods: goods, cart: cart)
            }
            .catch { [weak self] (_) in
                self?.titleLabel.text = ""
                self?.desLabel.text = ""
                self?.priceLabel.text = ""
                self?.countLabel.text = ""
                self?.coverImageView.kf.setImage(with: URL(string: ""))
            }
    }

    @IBAction func addButtonTap(_ sender: Any) {
        count = count + 1
        if checkButton.on {
            cart?.quantity = count
            guard  let cart = cart, let goods = goods else {
                return
            }
            delegate?.changeCart(cart: cart, goods: goods)
        }
    }
    
    @IBAction func lessButtonTap(_ sender: Any) {
        count = count - 1
        if count == 0 {
            delegate?.deleteCartItem(cart)
        }
        if checkButton.on {
            cart?.quantity = count
            guard  let cart = cart, let goods = goods else {
                return
            }
            delegate?.changeCart(cart: cart, goods: goods)
        }
    }
    
    func post() {
        guard let cart = cart else {
            return
        }
        var newCart = cart
        newCart.quantity = count
        CartAPI
            .updateCart(cartId: cart.id ?? 0, cart: newCart)
            .then { [weak self] (cart) -> Void in
                self?.cart = cart
                self?.countLabel.text = "\(self?.count ?? 0)"
            }
            .catch { (_) in
            }
    }
    
    @objc
    func change(notification: Notification) {
        let info = notification.userInfo
        let isOn: Bool = info?["isOn"] as! Bool
        checkButton.on = isOn
        guard let cart = cart, let goods = goods else {
            return
        }
        delegate?.checkBoxChange(isAdd: isOn, cart: cart, goods: goods)
    }
    
}

extension CommodityCell: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        guard let cart = cart, let goods = goods else {
            return
        }
        delegate?.checkBoxChange(isAdd: checkBox.on, cart: cart, goods: goods)
    }
}
