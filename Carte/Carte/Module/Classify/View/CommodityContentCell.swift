//
//  CommodityContentCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/4/9.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit

protocol CommodityContentCellDelegate: class {
    func didSelectCommodityContentCell(_ id: Int?)
}

struct CommodityContentCellRequired {
    let title: String
    let subItemRequireds: [CommoditySubItemCellRequired]
}


class CommodityContentCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentCollection: UICollectionView!
    
    var delegate: CommodityContentCellDelegate?
    
    var model: CommodityContentCellRequired? {
        didSet {
            config()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentCollection.delegate = self
        contentCollection.dataSource = self
        contentCollection.isScrollEnabled = false
        contentCollection.register(nib: CommoditySubItemCell.self)
    }
    
    private func config() {
        guard let model = model else {
            return
        }
        
        titleLabel.text = model.title
        contentCollection.reloadData()
    }
}

extension CommodityContentCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.screenWidth / 15 * 3.15, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.subItemRequireds.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CommoditySubItemCell = collectionView.dequeue(CommoditySubItemCell.self, forIndexPath: indexPath)
        cell.model = model?.subItemRequireds[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCommodityContentCell(model?.subItemRequireds[indexPath.row].categoryId)
    }
}
