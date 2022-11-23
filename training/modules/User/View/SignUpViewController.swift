//
//  SignUpViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 29/10/2022.
//

import UIKit

class SignUpViewController: UIViewController,UserViewDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    private var presenter : UserPresenterDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.addBottomBorder()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        signUpButton.addBottomShadow()
        self.presenter = UserPresenter(userViewDelegate:self)

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
        print("Register")
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text{
            presenter.register(name: name , email: email, phone: "0122776624", password: password)
        }
        else{
            print("fill all fields")
        }
    }
    
}
