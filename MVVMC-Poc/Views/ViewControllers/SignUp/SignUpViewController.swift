//
//  SignUpViewController.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController, Storyboarded {
    var viewModel: SignUpViewModel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding(with: viewModel)
        self.configureNavigationWithAction("SignUp", leftImage: nil, leftTitle: nil, actionForLeft: nil, rightImage: nil, rightTitle: nil, actionForRight: nil)
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        guard let userName = txtUserName.text else {return}
        viewModel.willSignUpSuccess(userID: userName)
    }
}
extension SignUpViewController {
    private func setupBinding(with viewModel: SignUpViewModel){
        viewModel.signUpDataResponse.subscribe(onNext: { (data) in
            if data.isSuccess {
                viewModel.didSignUpSuccess()
            }
        }).disposed(by: viewModel.disposeBag)
    }
}

