//
//  ForgotPasswordCoordinator.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ForgotPasswordViewController.instantiate()
        let viewModel = ForgotPasswordViewModel.init()
        vc.viewModel = viewModel
        viewModel.forgotCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }
}
