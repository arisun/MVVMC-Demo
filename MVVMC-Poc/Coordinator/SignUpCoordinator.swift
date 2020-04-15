//
//  SignUpCoordinator.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import UIKit

class SignUpCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SignUpViewController.instantiate()
        let viewModel = SignUpViewModel.init()
        vc.viewModel = viewModel
        viewModel.signUpCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.goToDashboard()
        //navigationController.popViewController(animated: true)
    }
}
