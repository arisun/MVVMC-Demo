//
//  LoginViewModel.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 14/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    weak var loginCoordinator: AppCoordinator?
    /// Network request in progress
    let isLoading: ActivityIndicator =  ActivityIndicator()

    var userIdText = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    
    var loginDataResponse: PublishSubject<LoginData>
    
    var isLoginValid: Observable<Bool> {
        return Observable.combineLatest(userIdText.asObservable(), passwordText.asObservable()) { uid, password in
            uid == "adam" && password == "password"
        }
    }
    
    override init() {
        loginDataResponse = PublishSubject<LoginData>()
        super.init()
    }
    func willLogin() {
        loginDataResponse.onNext(LoginData.init(success: true))
    }
    func goToDashBoard() {
        API.shared.fetchLiveNews()
            .asObservable()
            .trackActivity(isLoading)
            .subscribe(onNext: { (data) in
                if let data = data {
                    let model = DashBoardViewModel.init(dataModel: data)
                    self.loginCoordinator?.goToDashboard(withViewModel: model)
                }
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }).disposed(by: self.disposeBag)
    }
    func goToSIgnUp() {
        loginCoordinator?.goToSignUp()
    }
    func goToForgotPassword() {
        loginCoordinator?.goToForgotPassword()
    }
}
