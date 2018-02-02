//
//  MineFlow.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/2/1.
//  Copyright © 2018年 Wrappers. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift

enum MineStep: Step {
    case info(id: Int)
    case setting
    case user
}

class MineFlow: Flow {

    var root: UIViewController {
        return self.rootViewController
    }
    
    private let rootViewController: UIViewController

    init() {
        self.rootViewController = UIViewController()
    }
    
    func navigate(to step: Step) -> [Flowable] {
        guard let step = step as? MineStep else {
            return Flowable.noFlow
        }

        switch step {
        case .info(let id):
            return navigateToUserInfo(id: id)
        case .setting:
            return navigateToSetting()
        case .user:
            return navigateToUser()
        }
    }

    private func navigateToUserInfo(id: Int) -> [Flowable] {
        let infoController = UIViewController()
        infoController.view.backgroundColor = UIColor.flatLime
        infoController.title = "\(id)"
        rootViewController.navigationController?.pushViewController(infoController, animated: true)
        return [Flowable(nextPresentable: infoController, nextStepper: nil)]
    }

    private func navigateToSetting() -> [Flowable] {
        let settingViewController = UIViewController()
        settingViewController.view.backgroundColor = UIColor.flatPink
        settingViewController.title = "设置"
        rootViewController.navigationController?.pushViewController(settingViewController, animated: true)
        return [Flowable(nextPresentable: settingViewController, nextStepper: nil)]
    }
    
    private func navigateToUser() -> [Flowable] {
        let viewModel = MineViewModel()
        let mineViewControler = MineController(viewModel: viewModel)
        rootViewController.navigationController?.pushViewController(mineViewControler, animated: true)
        return [Flowable(nextPresentable: mineViewControler, nextStepper: viewModel)]
    }
}

