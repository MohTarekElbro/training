//
//  UserPresenter.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 09/11/2022.
//

import Foundation
import Alamofire

protocol UserPresenterDelegate{
    func login(_ email:String , _ password:String)
    func register(name:String , email:String , phone:String , password:String)
}

class UserPresenter:UserPresenterDelegate {
    private var userViewDelegate : UserViewDelegate?

    init(userViewDelegate: UserViewDelegate? = nil) {
        self.userViewDelegate = userViewDelegate
    }
    
    func setViewDelegate(userViewDelegate:UserViewDelegate?){
        self.userViewDelegate = userViewDelegate
    }
    
    func login(_ email:String , _ password:String){
        AF.request(UserRouter.login(email, password)).responseDecodable(of: RegisterResponse.self) { (response) in
            if let userLogin = response.value {
                switch userLogin.status {
                case true:
                    print("Successfully get token.")
                    self.userViewDelegate?.goToHome(token: userLogin.data!.token)
                case false:
                    print("Failed to get token with incorrect login info.")
                    self.userViewDelegate?.showError(message: "Failed to get token with incorrect login info.", status: false)

                }
            } else {
                print("Failed to get token.")
            }
        }
    }
    
    func register(name:String , email:String , phone:String , password:String){
        let body = ["name": name,
                    "phone": phone,
                    "email": email,
                    "password": password,
                    "image": ""]
        AF.request(UserRouter.register(body)).responseDecodable(of: RegisterResponse.self) { (response) in
            if let userLogin = response.value {
                switch userLogin.status {
                case true:
                    print("Successfully get token.")
                    self.userViewDelegate?.goToHome(token: userLogin.data!.token)
                case false:
                    print("Failed to get token with incorrect login info.")
                    self.userViewDelegate?.showError(message: "Failed to get token with incorrect login info.", status: false)

                }
            } else {
                print("Failed to get token.")
            }
        }
    }
}
