//
//  LoginViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 28/10/2022.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa



class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let loginViewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        loginButton.addBottomShadow()
        
        emailTextField.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.usernameTextPublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.passwordTextPublishSubject).disposed(by: disposeBag)
        
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map{$0 ? 1 : 0.5}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == K.singInToHome) {
//            if let secondView = segue.destination as? HomeViewController{
//                let token = sender as! String
//                secondView.token = token
//            }
//        }
//    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        loginViewModel.login()
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
    
    func goToHome(token: String) {
        K.token = token
        performSegue(withIdentifier: K.singInToHome, sender: token)
    }
    
    func showError(message: String?, status: Bool?) {
        print(message!)
        if let msg = message{
            self.showToast(msg)
        }
    }
}


