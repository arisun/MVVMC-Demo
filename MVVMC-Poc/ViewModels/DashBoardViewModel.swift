//
//  DashBoardViewModel.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DashBoardViewModel: BaseViewModel {
    weak var dashBoardCoordinator: DashboardCoordinator?
    var dasboardTableData: Observable<[DashBoardData]>
    private let dashBoardModel: BehaviorRelay<[DashBoardData]>!
    
    override init() {
        dashBoardModel = BehaviorRelay<[DashBoardData]>(value: [])
        self.dasboardTableData = dashBoardModel.asObservable()
        super.init()
    }
    func showDashBoardData() {
        dashBoardModel.accept(dashBoardModel.value + [DashBoardData.init(firstname: "Adam", lastname: "Michael")])
    }
    func addMoreData() {
        let str = String(Int.random(in: 0 ... 100))
        dashBoardModel.accept(dashBoardModel.value + [DashBoardData.init(firstname: "Adam \(str)", lastname: "Michael")])
    }
    func logOut() {
        dashBoardCoordinator?.didFinish()
    }
}
