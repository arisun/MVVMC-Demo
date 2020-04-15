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

class LoginViewController: UIViewController, Storyboarded {
    
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
        guard let userID = txtFieldUserID.text,
            let password = txtFieldPassword.text else { return }
        viewModel.willLogin(userID: userID, password: password)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        viewModel.goToSIgnUp()
    }
}
extension LoginViewController {
    private func setupBinding(with viewModel: LoginViewModel){
        viewModel.loginDataResponse.subscribe(onNext: { (data) in
            if data.isSuccess {
                viewModel.goToDashBoard()
            }
        }).disposed(by: viewModel.disposeBag)
    }
}
