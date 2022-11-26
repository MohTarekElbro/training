//
//  SignUpViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 29/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let registerViewModel = RegisterViewModel()
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.addBottomBorder()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        signUpButton.addBottomShadow()
        
        nameTextField.rx.text.map{$0 ?? ""}.bind(to: registerViewModel.nameObs).disposed(by: disposeBag)
        emailTextField.rx.text.map{$0 ?? ""}.bind(to: registerViewModel.emailObs).disposed(by: disposeBag)
        passwordTextField.rx.text.map{$0 ?? ""}.bind(to: registerViewModel.passwordObs).disposed(by: disposeBag)
        
        registerViewModel.isValid().bind(to: signUpButton.rx.isEnabled).disposed(by: disposeBag)
        registerViewModel.isValid().map{$0 ? 1 : 0.5}.bind(to: signUpButton.rx.alpha).disposed(by: disposeBag)

    }
    
    func goToHome(token: String) {
        performSegue(withIdentifier: K.singUpToHome, sender: self)
    }
    
    func showError(message: String?, status: Bool?) {
        if let msg = message{
            self.showToast(msg)
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        registerViewModel.register()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                switch response.status {
                case true:
                    self.goToHome(token: response.data!.token)
                case false:
                    self.showError(message: "Failed to get token with incorrect login info.", status: false)
                }
            }, onError: { error in
                print("error: \(error)")
            }).disposed(by: disposeBag)
        
    }
    
}
