//
//  DashboardCoordinator.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import UIKit

class DashboardCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DashBoardViewController.instantiate()
        let viewModel = DashBoardViewModel.init()
        vc.viewModel = viewModel
        viewModel.dashBoardCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func didFinish() {
        parentCoordinator?.childDidFinish(self, didSuccess: { [unowned self]  in
            self.navigationController.popToRootViewController(animated: true)
        })
    }
}
