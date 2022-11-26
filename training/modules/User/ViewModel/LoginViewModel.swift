//
//  LoginViewModel.swift
//  training
//
//  Created by Mohammed Tarek on 24/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel{
    let usernameTextPublishSubject = BehaviorRelay<String>(value: "")
    let passwordTextPublishSubject = BehaviorRelay<String>(value: "")
    
    func isValid() -> Observable<Bool>{
        return Observable.combineLatest(usernameTextPublishSubject.asObservable().startWith("motarekelbro@gmail.com"), usernameTextPublishSubject.asObservable().startWith("123456")).map{username , password in
            return username.count>3 && password.count>3
        }.startWith(true)
    }
    
     func login() -> Observable<RegisterResponse> {
         return UserRouter.request(UserRouter.login(self.usernameTextPublishSubject.value ,self.passwordTextPublishSubject.value))
    }
    
}
