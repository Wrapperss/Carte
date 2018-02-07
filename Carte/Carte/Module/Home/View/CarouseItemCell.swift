//
//  CarouseItemCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Then
import SnapKit
import ChameleonFramework
import Kingfisher

class CarouseItemCell: UICollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.cornerRadius = 10
        $0.layer.shadowColor = UIColor.flatGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    let redLabel = UILabel().then {
        $0.textColor = UIColor.flatRed
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let mediumLabel = UILabel().then {
        $0.textColor = UIColor.flatBlack
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    
    let grayLabel = UILabel().then {
        $0.textColor = UIColor.flatGray
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(imageView)
        addSubview(redLabel)
        addSubview(mediumLabel)
        addSubview(grayLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        redLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        
        mediumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(redLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
        }
        
        grayLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(mediumLabel.snp.bottom).offset(5)
        }
    }
    
    func config() {
        
    }
}
