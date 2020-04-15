//
//  DashBoardViewController.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DashBoardViewController: UIViewController, Storyboarded {
    
    var viewModel: DashBoardViewModel!
    @IBOutlet weak var tblList :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationWithAction("DashBoard", leftImage: nil, leftTitle: "Add",actionForLeft: { [unowned self] in
            self.viewModel.addMoreData()
        }, rightImage: nil, rightTitle: "LogOut") { [unowned self] in
            self.viewModel.logOut()
        }
        setupBinding(with: viewModel)
        viewModel.showDashBoardData()
        print("asasassa")
        // Do any additional setup after loading the view.
    }
}
extension DashBoardViewController {
    private func setupBinding(with viewModel: DashBoardViewModel){
        viewModel.dasboardTableData.asObservable()
            .bind(to: tblList.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = element.firstName
                cell.detailTextLabel?.text = element.lastName
        }.disposed(by: viewModel.disposeBag)
    }
}
