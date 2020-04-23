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
    private var viewModel: DashBoardViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    convenience init(model: DashBoardViewModel, navigationController: UINavigationController) {
        self.init(navigationController: navigationController)
        viewModel = model
    }
    
    func start() {
        let vc = DashBoardViewController.instantiate()
        if let model = viewModel {
            vc.viewModel = model
        } else {
            viewModel = DashBoardViewModel.init()
        }
        vc.viewModel = viewModel
        viewModel?.dashBoardCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func didFinish() {
        parentCoordinator?.childDidFinish(self, didSuccess: { [unowned self]  in
            self.navigationController.popToRootViewController(animated: true)
        })
    }
}
