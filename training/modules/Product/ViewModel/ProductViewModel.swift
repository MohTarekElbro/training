//
//  ProductViewModel.swift
//  training
//
//  Created by Mohammed Tarek on 25/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class ProductViewModdel{
    let product = BehaviorRelay<Product?>(value: nil)
    
    func addToCart() -> Observable<ProductResponse> {
        return ProductRouter.request(ProductRouter.addProductToCart(K.token, self.product.value!.id))
    }
    
}
