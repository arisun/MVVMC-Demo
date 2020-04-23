//
//  AppCoordinator.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController.instantiate()
        let viewModel = LoginViewModel.init()
        loginVC.viewModel = viewModel
        viewModel.loginCoordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func goToSignUp() {
        let coordinator = SignUpCoordinator.init(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToForgotPassword() {
        let coordinator = ForgotPasswordCoordinator.init(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToDashboard(withViewModel: DashBoardViewModel? = nil) {
        var coordinator: DashboardCoordinator
        if let vwModel = withViewModel {
            coordinator = DashboardCoordinator.init(model: vwModel, navigationController: navigationController)
        } else {
            coordinator = DashboardCoordinator.init(navigationController: navigationController)
        }
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?, didSuccess: (() -> Void)? = nil) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                if let success = didSuccess {
                    success()
                }
                break
            }
        }
    }
}
