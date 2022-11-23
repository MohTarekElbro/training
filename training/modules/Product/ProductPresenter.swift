//
//  ProductPresenter.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 09/11/2022.
//

import Foundation
import Alamofire

import RealmSwift

protocol ProductPresenterDelegate{
    func getCategories()
    func getProducts(token:String)
    func addProductToCart(token:String , product_id:Int)
}

class ProductPresenter:ProductPresenterDelegate{
    private var productViewDelegate:ProductViewDelegate?

    init(productViewDelegate: ProductViewDelegate? = nil) {
        self.productViewDelegate = productViewDelegate
    }
    
    func getCategories(){
        AF.request(ProductRouter.categories).responseDecodable(of: CategoryResponse.self) { (response) in
            if let categoriesResponse = response.value {
                switch categoriesResponse.status {
                case true:
                    self.productViewDelegate?.loadCategories(categories: categoriesResponse.data!.data)
                case false:
                    self.productViewDelegate?.showProductError(message: "Failed to get token with incorrect login info.", status: false)

                }
            } else {
                print("Failed to get token.")
                print(response)
            }
        }
    }
    
    func getProducts(token:String){
        AF.request(ProductRouter.products(token)).responseDecodable(of: ProductResponse.self) { (response) in
            if let productsResponse = response.value {
                switch productsResponse.status {
                case true:
                    self.productViewDelegate?.loadProducts(products: productsResponse.data!.data)
                case false:
                    self.productViewDelegate?.showProductError(message: "Failed to get token with incorrect login info.", status: false)

                }
            } else {
                print("Failed to get token.")
                print(response)

            }
        }
    }
    
    func addProductToCart(token:String , product_id:Int){
        AF.request(ProductRouter.addProductToCart(token, product_id)).responseDecodable(of: ProductResponse.self) { (response) in
            if let productsResponse = response.value {
                switch productsResponse.status {
                case true:
                    self.productViewDelegate?.openCart()
                case false:
                    self.productViewDelegate?.showProductError(message: "Failed to get token with incorrect login info.", status: false)

                }
            } else {
                print("Failed to get token.")
            }
        }
    }
}
