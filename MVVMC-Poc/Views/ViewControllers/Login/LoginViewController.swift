//
//  ViewController.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, Storyboarded, LoaderViewable {
    
    @IBOutlet weak var txtFieldUserID: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding(with: viewModel)
        // Do any additional setup after loading the view.
    }
    @IBAction func forgotPasswordAction(_ sender: Any) {
        viewModel.goToForgotPassword()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        viewModel.willLogin()
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        viewModel.goToSIgnUp()
    }
}
extension LoginViewController {
    private func setupBinding(with viewModel: LoginViewModel){
        _ = txtFieldUserID.rx.text.map{ $0 ?? "" }.bind(to: viewModel.userIdText)
        _ = txtFieldPassword.rx.text.map{ $0 ?? "" }.bind(to: viewModel.passwordText)
        _ = viewModel.isLoginValid.bind(to: btnSignIn.rx.isEnabled)
        
        
//        viewModel.isLoadingAc
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] (isloading) in
//            if isloading {
//                self.showActivityIndicator()
//            } else {
//                self.hideActivityIndicator()
//            }
//            }, onCompleted: {
//                self.hideActivityIndicator()
//            }).disposed(by: viewModel.disposeBag)
        
        viewModel.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let `self` = self else { return }
                self.hideActivityIndicator()
                if isLoading {
                    self.showActivityIndicator()
                }
            }).disposed(by: viewModel.disposeBag)
        
        
        viewModel.loginDataResponse.subscribe(onNext: { (data) in
            if data.isSuccess {
                viewModel.goToDashBoard()
            }
        }).disposed(by: viewModel.disposeBag)
    }
}
