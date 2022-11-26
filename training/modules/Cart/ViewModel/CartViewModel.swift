//
//  CartViewModel.swift
//  training
//
//  Created by Mohammed Tarek on 25/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class CartViewModel{
    let products = BehaviorRelay<[Cart]>(value: Array<Cart>())
    
    func loadCart() -> Observable<GetCartResponse> {
        return CartRouter.request(CartRouter.cart(K.token))
    }
    
}
