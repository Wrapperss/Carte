//
//  MoreInfoController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/5.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import IGListKit

class MoreInfoController: BaseListViewController {
    
    var goodsId: Int
    
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
    }
    
    fileprivate func prepare(_ goods: Goods) {
        source = [
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("产地", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute(goods.origin ?? "-", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                    arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                        location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                    height: 70,
                    backgroundColor: UIColor(r: 245, g: 245, b: 245)),
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("品牌", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute(goods.brand ?? "-", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                     height: 70,
                     backgroundColor: .white),
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("保质期", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute(goods.shelfLife ?? "-", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                     height: 70,
                     backgroundColor: UIColor(r: 245, g: 245, b: 245)),
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("储藏条件", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute(goods.storage ?? "-", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                     height: 70,
                     backgroundColor: .white),
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("生产商", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute(goods.manufacturer ?? "-", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                     height: 70,
                     backgroundColor: UIColor(r: 245, g: 245, b: 245)),
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("包装方式", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute(goods.packing ?? "-", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                     height: 70,
                     backgroundColor: .white),
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("类型", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute(goods.type ?? "-", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                     height: 70,
                     backgroundColor: UIColor(r: 245, g: 245, b: 245)),
            FormItem(elements: [TextElement(text: NSAttributedString.attribute("库存", .black, fontSize: 17)),
                                TextElement(text: NSAttributedString.attribute("剩余\(goods.stock ?? 0)", UIColor(r: 73, g: 76, b: 82), fontSize: 17))],
                     arrange: TwoArrange(ArrangeCommon(ArrangeCommon.Direction.horizontal, ArrangeCommon.Alignment.center),
                                         location: TwoArrange.Location.symmetric(style: TwoArrange.Location.SymmetricStyle.siding, spaces: (first: 15, last: 15))),
                     height: 70,
                     backgroundColor: .white)
        ]
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        adapter.dataSource = self
        title = "商品详情"
        collectionView.backgroundColor = .white
    }
    
    override func addConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}

extension MoreInfoController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FormSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return emptyLabel(message: "暂无数据")
    }
}

extension MoreInfoController {
    fileprivate func fetch() {
        HUD.wait()
        ClassifyAPI
            .fetchGoodsDetail(goodsId)
            .always {
                HUD.clear()
            }
            .then { [weak self] (goods) -> Void in
                self?.prepare(goods)
                self?.adapter.reloadData(completion: nil)
            }
            .catch { (_) in
                HUD.showError("发送错误")
        }
    }
}
