//
//  LoginViewModel.swift
//  training
//
//  Created by Mohammed Tarek on 24/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel{
    let nameObs = BehaviorRelay<String>(value: "")
    let emailObs = BehaviorRelay<String>(value: "")
    let passwordObs = BehaviorRelay<String>(value: "")
    
    func isValid() -> Observable<Bool>{
        return Observable.combineLatest(nameObs.asObservable().startWith(""), emailObs.asObservable().startWith("") , passwordObs.asObservable().startWith("")).map{name , email , password in
            return name.count>3 && email.count>3 && password.count>3
        }.startWith(false)
    }
    
    func register() -> Observable<RegisterResponse> {
        let body = ["name": self.nameObs.value,
                    "phone": "123456789",
                    "email": self.emailObs.value,
                    "password": self.passwordObs.value,
                    "image": ""]
        return UserRouter.request(UserRouter.register(body))
    }
    
}
