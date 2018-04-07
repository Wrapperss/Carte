//
//  CarouseCompositionCell.swift
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

struct CarouseCompositionRequired {
    let imageUrl: String
    let redTitle: String
    let mediumTitle: String
    let grayTitle: String
}

class CarouseCompositionCell: UICollectionViewCell {
    
    static let size = CGSize(width: UIScreen.screenWidth - 20, height: 200)
    
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
        $0.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
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
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }
        
        redLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        
        mediumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(redLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        grayLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(mediumLabel.snp.bottom).offset(5)
        }
    }
    
    func config(_ model: CarouseCompositionRequired?) {
        guard let model = model else {
            return
        }
        imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.imageUrl)!))
        redLabel.text = model.redTitle
        mediumLabel.text = model.mediumTitle
        grayLabel.text = model.grayTitle
    }
}
