//
//  CarouselCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Then
import IGListKit
import ChameleonFramework

struct CarouseCellRequired {
    var data: [CarouseCompositionRequired]
}

class CarouseCell: UICollectionViewCell {
    
    static let height: CGFloat = 250
    
     private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.screenWidth, height: 250)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    var model: CarouseCellRequired?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        collectionView.register(CarouseCompositionCell.self, forCellWithReuseIdentifier: "CarouseItem")
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func config(_ model: CarouseCellRequired?) {
        self.model = model
        collectionView.reloadData()
    }
}

extension CarouseCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.data.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarouseCompositionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouseItem", for: indexPath) as! CarouseCompositionCell
        cell.config(model?.data[indexPath.row])
        return cell
    }
}
