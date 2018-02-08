//
//  HeadlineCell.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/7.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import UIKit
import Then
import SnapKit
import ChameleonFramework
import RxSwift
import RxCocoa

struct HeadlineRequired {
    
    enum HeadlineType {
        case instructions
        case seeMoreButton
        case none
    }
    
    var title: String
    var description: String
    var type: HeadlineType
    var imageCount: Int?
    var seeMoreButtonClick: (() -> Void)?
    
    init(title: String, description: String, type: HeadlineType, imageCount: Int?, seeMoreButtonClick: (() -> Void)? = nil) {
        self.title = title
        self.description = description
        self.type = type
        self.imageCount = imageCount
        self.seeMoreButtonClick = seeMoreButtonClick
        switch self.type {
        case .instructions:
            if imageCount == nil {
                self.type = .none
            }
        case .seeMoreButton:
            if seeMoreButtonClick == nil {
                self.type = .none
            }
        default:
            break
        }
    }
}

class HeadlineCell: UICollectionViewCell {
    
    var titleLabel = UILabel().then {
        $0.textColor = UIColor.flatBlack
        $0.font = UIFont.systemFont(ofSize: 25, weight: .medium)
    }
    
    var descriptionLabel = UILabel().then {
        $0.textColor = UIColor.flatGray
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    var seeMoreButton = UIButton().then {
        $0.setTitle("查看更多", for: .normal)
        $0.setTitleColor(UIColor.flatRed, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    var instructionsLabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    static let height: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(15)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
    }
    
    func config(_ model: HeadlineRequired?) {
        guard  let model = model else {
            return
        }
        
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        
        switch model.type {
        case .instructions:
            instructionsLabel.text = "1/\(model.imageCount ?? 1)"
            addSubview(instructionsLabel)
            
            instructionsLabel.snp.makeConstraints({ (make) in
                make.trailing.equalToSuperview().offset(-20)
                make.bottom.equalTo(titleLabel.snp.bottom)
            })
            
        case .seeMoreButton:
            seeMoreButton
                .rx
                .tap
                .asObservable()
                .bind(onNext: { model.seeMoreButtonClick!() })
                .disposed(by: disposeBag)
            
            addSubview(seeMoreButton)
            
            seeMoreButton.snp.makeConstraints({ (make) in
                make.trailing.equalToSuperview().offset(20)
                make.bottom.equalTo(titleLabel.snp.bottom)
            })
        default:
            break
        }
    }
    
    
}
