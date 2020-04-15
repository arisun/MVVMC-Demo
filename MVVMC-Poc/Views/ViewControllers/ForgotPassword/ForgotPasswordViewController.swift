//
//  ForgotPasswordViewController.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 09/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForgotPasswordViewController: UIViewController, Storyboarded {
    var viewModel: ForgotPasswordViewModel!
    @IBOutlet weak var txtUserID: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding(with: viewModel)
        self.configureNavigationWithAction("Forgot Password", leftImage: nil, leftTitle: nil, actionForLeft: nil, rightImage: nil, rightTitle: nil, actionForRight: nil)
    }
    @IBAction func btnContinueAction(_ sender: Any) {
        guard let userName = txtUserID.text else {return}
        viewModel.willSuccess(userID: userName)
    }
}
extension ForgotPasswordViewController {
    private func setupBinding(with viewModel: ForgotPasswordViewModel){
        viewModel.forgotPasswordDataResponse.subscribe(onNext: { (data) in
            if data.isSuccess {
                viewModel.didSuccess()
            }
        }).disposed(by: viewModel.disposeBag)
    }
}
