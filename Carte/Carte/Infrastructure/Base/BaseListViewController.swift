//
//  BaseListViewController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import IGListKit

class BaseListViewController: BaseViewController {
    
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.backgroundColor
        return view
    }()
    
    internal lazy var adapter: ListAdapter = {
        return ListAdapter.init(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 4)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
    }
}

