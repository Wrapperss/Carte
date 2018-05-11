//
//  AddCommentController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/11.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import Then
import SnapKit
import GRStarsView

class AddCommentController: BaseViewController {
    
    private static let StarViewSize = CGSize(width: 30, height: 20)
    
    let textView = UITextView()
    let desLabel = UILabel()
    let desStarView = GRStarsView(starSize: StarViewSize, margin: 10, numberOfStars: 5)
    let logisLabel = UILabel()
    let logisStarView = GRStarsView(starSize: StarViewSize, margin: 10, numberOfStars: 5)
    let recommendLabel = UILabel()
    let recomendStarView = GRStarsView(starSize: StarViewSize, margin: 10, numberOfStars: 5)
    
    let comfirmButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setNavigation()
        view.backgroundColor = .backgroundColor
        
        desLabel.text = "描述相符："
        desLabel.textColor = .black
        desLabel.font = UIFont.systemFont(ofSize: 20)
        
        desStarView?.score = 0.0
        desStarView?.allowDragSelect = true
        desStarView?.allowSelect = true
        desStarView?.allowDecimal = false
        
        
        logisLabel.text = "物流相符："
        logisLabel.textColor = .black
        logisLabel.font = UIFont.systemFont(ofSize: 20)
        
        logisStarView?.score = 0.0
        logisStarView?.allowDragSelect = true
        logisStarView?.allowSelect = true
        logisStarView?.allowDecimal = false
        
        recommendLabel.text = "推荐指数："
        recommendLabel.textColor = .black
        recommendLabel.font = UIFont.systemFont(ofSize: 20)
        
        recomendStarView?.score = 0.0
        recomendStarView?.allowDragSelect = true
        recomendStarView?.allowSelect = true
        recomendStarView?.allowDecimal = false
        
        
        comfirmButton.setTitle("提交", for: .normal)
        comfirmButton.backgroundColor = UIColor(r: 252, g: 29, b: 44)
        comfirmButton.setTitleColor(.white, for: .normal)
        comfirmButton.addTarget(self, action: #selector(comfirmButtonTap), for: .touchUpInside)
    }
    
    private func setNavigation() {
        title = "添加评论"
    }
    
    override func addConstraints() {
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }
        
        view.addSubview(desLabel)
        desLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(textView.snp.bottom).offset(20)
        }
        
        view.addSubview(desStarView!)
        desStarView?.snp.makeConstraints { (make) in
            make.leading.equalTo(desLabel.snp.trailing).offset(10)
            make.top.equalTo(desLabel.snp.top)
            make.size.equalTo(CGSize(width: ( AddCommentController.StarViewSize.width + 10) * 5 , height: 20))
        }
        
        view.addSubview(logisLabel)
        logisLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(desLabel.snp.bottom).offset(20)
        }
        
        view.addSubview(logisStarView!)
        logisStarView?.snp.makeConstraints { (make) in
            make.leading.equalTo(logisLabel.snp.trailing).offset(10)
            make.top.equalTo(logisLabel.snp.top)
            make.size.equalTo(CGSize(width: ( AddCommentController.StarViewSize.width + 10) * 5 , height: 20))
        }
        
        view.addSubview(recommendLabel)
        recommendLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(logisLabel.snp.bottom).offset(20)
        }
        
        view.addSubview(recomendStarView!)
        recomendStarView?.snp.makeConstraints { (make) in
            make.leading.equalTo(recommendLabel.snp.trailing).offset(10)
            make.top.equalTo(recommendLabel.snp.top)
            make.size.equalTo(CGSize(width: ( AddCommentController.StarViewSize.width + 10) * 5 , height: 20))
        }
        
        view.addSubview(comfirmButton)
        comfirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(recommendLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc
    private func comfirmButtonTap() {
        
    }
}

