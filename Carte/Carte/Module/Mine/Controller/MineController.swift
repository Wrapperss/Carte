//
//  MineController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import ReactorKit
import IGListKit
import Then
import ChameleonFramework
import SnapKit

class MineController: BaseListViewController, View {
    typealias Reactor = MineViewModel
    
    var viewModel: MineViewModel?
    
    convenience init(viewModel: MineViewModel) {
        self.init()
        self.viewModel = viewModel
        reactor = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.dataSource = self
        view.backgroundColor = UIColor.flatRed
        
        let infoButton = UIButton().then {
            $0.backgroundColor = UIColor.flatBlue
            $0.cornerRadius = 10
            $0.setTitle("info", for: .normal)
            $0.addTarget(self, action: #selector(clickInfoBotton), for: .touchUpInside)
        }
        
        let settingButton = UIButton().then {
            $0.backgroundColor = UIColor.flatGray
            $0.cornerRadius = 10
            $0.setTitle("setting", for: .normal)
            $0.addTarget(self, action: #selector(clickSettingButton), for: .touchUpInside)
        }
        
        view.addSubview(infoButton)
        view.addSubview(settingButton)
        
        infoButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.size.equalTo(CGSize(width: 150, height: 100))
        }
        
        settingButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoButton.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 150, height: 100))
        }
    }
    
    @objc
    func clickInfoBotton() {
        navigationController?.pushViewController(RNViewController(fileUrl: "index", initProps: nil), animated: true)
    }
    @objc
    func clickSettingButton() {
        
    }
    func bind(reactor: MineViewModel) {
        
    }
    
    
}

extension MineController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [ListDiffable]()
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
