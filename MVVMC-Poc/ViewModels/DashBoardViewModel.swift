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
    var dasboardTableData: Observable<[Articles]>!
    let isLoading: ActivityIndicator =  ActivityIndicator()
    
    private var dashBoardModel: BehaviorRelay<[Articles]>!
    private var dashBoardData: DashBoardDataModel!
    
    override init() {
        dashBoardModel = BehaviorRelay<[Articles]>.init(value: [])
        self.dasboardTableData = dashBoardModel.asObservable()
        super.init()
    }
    convenience init(dataModel: DashBoardDataModel) {
        self.init()
        self.dashBoardData = dataModel
    }
    func showDashBoardData() {
        self.dashBoardModel.accept(self.dashBoardModel.value + dashBoardData.articles!)
        self.dasboardTableData = self.dashBoardModel.asObservable()
    }
    func addMoreData() {
        API.shared.fetchLiveNews()
            .asObservable()
            .trackActivity(isLoading)
            .subscribe(onNext: { [unowned self] (data) in
                if let data = data {
                    self.dashBoardModel.accept(self.dashBoardModel.value + data.articles!)
                    self.dasboardTableData = self.dashBoardModel.asObservable()
                }
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }).disposed(by: self.disposeBag)
        
//        API.shared.fetchLiveNews { [unowned self] (data, error) in
//            if let data = data {
//                self.dashBoardModel.accept(self.dashBoardModel.value + data.articles!)
//                self.dasboardTableData = self.dashBoardModel.asObservable()
//            }
//        }
    }
    func logOut() {
        Logger.shared.uploadLogFile()
        dashBoardCoordinator?.didFinish()
    }
}
