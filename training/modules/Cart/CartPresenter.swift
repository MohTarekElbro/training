//
//  CartPresenter.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 09/11/2022.
//

import Foundation
import Alamofire


protocol CartPresenterDelegate{
    func getCart(token:String)

}
class CartPresenter:CartPresenterDelegate{
    
    private var cartViewDelegate:CartViewDelegate?
     init(viewDelegate:CartViewDelegate){
        self.cartViewDelegate = viewDelegate
    }
    
    func getCart(token:String){
        AF.request(CartRouter.cart(token)).responseDecodable(of: GetCartResponse.self) { (response) in
            if let cartResponse = response.value {
                switch cartResponse.status {
                case true:
                    self.cartViewDelegate?.loadCart(cartItems: cartResponse.data!.cartItems)
                case false:
                    self.cartViewDelegate?.showCartError(message: "Failed to get token with incorrect login info.", status: false)

                }
            } else {
                print("Failed to get token.")
                print(response)

            }
        }
    }
}
