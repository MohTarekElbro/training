//
//  LoginViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 28/10/2022.
//

import UIKit
import Alamofire

protocol UserViewDelegate{
    func goToHome(token:String)
    func showError(message:String? , status:Bool?)
}

class LoginViewController: UIViewController,UserViewDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
//    var userPresenter = UserPresenter()
    
    private var presenter : UserPresenterDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        loginButton.addBottomShadow()
        self.presenter = UserPresenter(userViewDelegate:self)
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        print("Login")
        if let email = emailTextField.text, let password = passwordTextField.text{
            self.presenter.login(email, password)
        }
        else{
            print("fill all fields")
            self.showToast("fill all fields")
        }
    }
    
    func goToHome(token: String) {
        performSegue(withIdentifier: K.singInToHome, sender: token)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.singInToHome) {
            if let secondView = segue.destination as? HomeViewController{
                
                let token = sender as! String
                secondView.token = token
                
            }
        }
    }
    
    func showError(message: String?, status: Bool?) {
        print(message!)
        if let msg = message{
            self.showToast(msg)
        }
    }
}

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: frame.height - 1, width: frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        borderStyle = UITextField.BorderStyle.none
        layer.addSublayer(bottomLine)
    }
    
    
}
