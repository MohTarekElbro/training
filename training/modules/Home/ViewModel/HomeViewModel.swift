//
//  HomeViewModel.swift
//  training
//
//  Created by Mohammed Tarek on 24/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel{
    let categories = BehaviorRelay<[Category]>(value: Array<Category>())
    let products = BehaviorRelay<[Product]>(value: Array<Product>())
    
    func getCategories() -> Observable<CategoryResponse> {
        return ProductRouter.request(ProductRouter.categories)
    }
    func getProducts() -> Observable<ProductResponse> {
        return ProductRouter.request(ProductRouter.products(K.token))
    }
    
}
