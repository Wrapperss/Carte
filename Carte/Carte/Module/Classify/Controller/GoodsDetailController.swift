//
//  GoodsDetailController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import SnapKit
import IGListKit
import PromiseKit

class GoodsDetailController: BaseListViewController {
    
    var goodsId: Int
    
    let banerView = GoodBanerView.initFromNib()
    
    var comments = [Comment]()
    
    var goods: Goods?
    
    var isCollect: Bool = false {
        didSet {
            if isCollect {
                navigationItem.rightBarButtonItem?.title = "已收藏"
                navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 252, g: 29, b: 44)
            } else {
                navigationItem.rightBarButtonItem?.title = "收藏"
                navigationItem.rightBarButtonItem?.tintColor = .black
            }
        }
    }
    
    init(goodsId: Int) {
        self.goodsId = goodsId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetch()
        fetchIsCollect()
    }
    
    private func setupUI() {
        setupNavigation()
        collectionView.backgroundColor = UIColor.backgroundColor
        view.backgroundColor = .white
        adapter.dataSource = self
        
        banerView.delegate = self
    }
    
    private func setupNavigation() {
        title = "商品详情"
        let rightItem = UIBarButtonItem(title: "收藏", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addCollection))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        
        view.addSubview(banerView)
        banerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(60)
        }
    }
    
    
    @objc
    private func addCollection() {
        isCollect = !isCollect
        HUD.wait()
        if isCollect {
            CollectionAPI
                .postCollectGoods(userId: Default.Account.integer(forKey: .userId), goodsId: goodsId)
                .always { [weak self] in
                    HUD.clear()
                    self?.navigationItem.rightBarButtonItem?.title = "已收藏"
                    self?.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 252, g: 29, b: 44)
                }
        } else {
            CollectionAPI
                .deleteCollectGoods(userId: Default.Account.integer(forKey: .userId), goodsId: goodsId)
                .always { [weak self] in
                    HUD.clear()
                    self?.navigationItem.rightBarButtonItem?.title = "收藏"
                    self?.navigationItem.rightBarButtonItem?.tintColor = .black
            }
        }
    }
}


extension GoodsDetailController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is GoodsHeaderSectionItem {
            return GoodsHeaderSectionController()
        }
        if object is GoodsInfoSectionItem {
            return GoodsInfoSectionController(delegate: self)
        }
        if object is GoodsFeaturesSectionItem {
            return GoodsFeaturesSectionController()
        }
        if object is GoodsPostageSectionItem {
            return GoodsPostageSectionController()
        }
        if object is GoodsCommentCoverSectionItem {
            return GoodsCommentCoverSectionController(delegate: self)
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension GoodsDetailController: GoodsInfoSectionControllerDelegate, GoodsCommentCoverSectionControllerDelegate{
    func tapToMoreInfo() {
        navigationController?.pushViewController(MoreInfoController.init(goodsId: goodsId), animated: true)
    }
    
    func didSelectCommentCoverItem() {
        navigationController?.pushViewController(CommentListController(comments: comments), animated: true)
    }
}

extension GoodsDetailController: GoodBanerViewDelegate {
    func toCart() {
        navigationController?.pushViewController(CartController(), animated: true)
    }
    
    func addCart() {
        HUD.wait()
        CartAPI
            .addCart(Cart(goodsId: goodsId,
                          userId: Default.Account.integer(forKey: .userId),
                          quantity: 1))
            .always {
                HUD.clear()
            }
            .then { (_) -> Void in
                HUD.showSuccess("添加购物车成功")
            }
            .catch { (_) in
                HUD.showError("添加购物车失败")
            }
    }
    
    func toBuy() {
        guard let goods = goods else {
            return
        }
        let cart = Cart(goodsId: goods.id ?? 0, userId: Default.Account.integer(forKey: .userId), quantity: 1)
        
        navigationController?.pushViewController(ConfirmOrderController(cartMsg: [(cart, goods)]), animated: true)
    }
}

extension GoodsDetailController {
    fileprivate func fetch() {
        HUD.wait()
        ClassifyAPI
            .fetchGoodsDetail(goodsId)
            .always {
                HUD.clear()
            }
            .then { [weak self] (goods) -> Void in
                self?.goods = goods
                CommentAPI
                    .fetchGoddsComment(self?.goodsId ?? 0)
                    .then(execute: { (comments) -> Void in
                        if comments.count > 0 {
                            self?.comments = comments
                            self?.source = DataFactory.sectionItem.prepareGoodsDetailItem(goods, comment: comments.first!)
                        } else {
                            self?.source = DataFactory.sectionItem.prepareGoodsDetailItem(goods)
                        }
                        self?.adapter.reloadData(completion: nil)
                    })
                    .catch(execute: { (_) in
                        HUD.showError("发生错误")
                    })
            }
            .catch { (_) in
                HUD.showError("发送错误")
        }
    }
    
    fileprivate func fetchIsCollect() {
        CollectionAPI
            .fetchIsCollectGoods(userId: Default.Account.integer(forKey: .userId), goodsId: goodsId)
            .then { [weak self] (_) -> Void in
                self?.isCollect = true
            }
            .catch { (_) in
                self.isCollect = false
            }
    }
}
