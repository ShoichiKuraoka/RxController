//
//  AppFlow.swift
//  RxController_Example
//
//  Created by Meng Li on 2019/04/09.
//  Copyright © 2019 MuShare. All rights reserved.
//

import UIKit
import RxFlow

enum AppStep: Step {
    case start
    case child
    case childIsComplete
}

class AppFlow: Flow {
    
    var root: Presentable {
        return rootWindow
    }
    
    private let rootWindow: UIWindow
    
    private lazy var navigationController = UINavigationController()
    
    init(window: UIWindow) {
        rootWindow = window
        rootWindow.rootViewController = navigationController
    }
   
    func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else {
            return .none
        }
        switch appStep {
        case .start:
            let menuViewController = MenuViewController(viewModel: .init())
            navigationController.pushViewController(menuViewController, animated: false)
            return .viewController(menuViewController)
        case .child:
            return present(InfoViewController(viewModel: InfoViewModel()))
        case .childIsComplete:
            guard
                let menuViewController = navigationController.topViewController as? MenuViewController,
                let infoViewController = menuViewController.presentedViewController as? InfoViewController
            else {
                return .none
            }
            infoViewController.dismiss(animated: true)
            return .none
        }
    }
    
}
