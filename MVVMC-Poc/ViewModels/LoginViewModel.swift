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

    //var loginData: Observable<[LoginData]>
    var loginDataResponse: PublishSubject<LoginData>
    //private let loginModel: BehaviorRelay<[LoginData]>!
    
    override init() {
        //loginModel = BehaviorRelay<[LoginData]>(value: [])
        loginDataResponse = PublishSubject<LoginData>()
        //self.loginData = loginModel.asObservable()
        super.init()
    }
    func willLogin(userID: String, password: String) {
        if userID == "adam", password == "password" {
            loginDataResponse.onNext(LoginData.init(success: true))
        } else {
            loginDataResponse.onNext(LoginData.init(success: false))
        }
    }
    func goToDashBoard() {
        loginCoordinator?.goToDashboard()
    }
    func goToSIgnUp() {
        loginCoordinator?.goToSignUp()
    }
    func goToForgotPassword() {
        loginCoordinator?.goToForgotPassword()
    }
}
