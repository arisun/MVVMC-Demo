//
//  SignUpViewModel.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 15/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewModel: BaseViewModel {
    weak var signUpCoordinator: SignUpCoordinator?
    var signUpDataResponse: PublishSubject<SignUpData>
    
    override init() {
        signUpDataResponse = PublishSubject<SignUpData>()
        super.init()
    }
    func willSignUpSuccess(userID: String?) {
        if let _userID = userID, !_userID.isEmpty {
            signUpDataResponse.onNext(SignUpData.init(success: true))
        } else {
            signUpDataResponse.onNext(SignUpData.init(success: false))
        }
    }
    func didSignUpSuccess() {
        signUpCoordinator?.didFinish()
    }
}

