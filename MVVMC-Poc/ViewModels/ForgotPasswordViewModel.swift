//
//  ForgotPasswordViewModel.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 15/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForgotPasswordViewModel: BaseViewModel {
    weak var forgotCoordinator: ForgotPasswordCoordinator?
    
    var forgotPasswordDataResponse: PublishSubject<ForgotPasswordData>
    
    override init() {
        forgotPasswordDataResponse = PublishSubject<ForgotPasswordData>()
        super.init()
    }
    func willSuccess(userID: String?) {
        if let _userID = userID, !_userID.isEmpty {            forgotPasswordDataResponse.onNext(ForgotPasswordData.init(success: true))
        } else {            forgotPasswordDataResponse.onNext(ForgotPasswordData.init(success: false))
        }
    }
    func didSuccess() {
        forgotCoordinator?.didFinish()
    }
}
