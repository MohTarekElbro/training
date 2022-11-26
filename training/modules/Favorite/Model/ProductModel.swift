//
//  ProductModel.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 10/11/2022.
//

import Foundation
import RealmSwift
class ProductModel:Object{
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var price :Double = 0
    @Persisted var oldPrice: Double = 0
    @Persisted var discount: Int = 0
    @Persisted var image: String = ""
    @Persisted var name = ""
    @Persisted var datumDescription: String = ""
    var images = Array<String>()
    @Persisted var inCart: Bool = false
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
//
    static func create(id:Int , price:Double , oldPrice:Double , image:String , name:String , images:Array<String> , inCart:Bool , description:String)->ProductModel {
        let product = ProductModel()
        product.id = id
        product.price = price
        product.oldPrice = oldPrice
        product.image = image
        product.name = name
        product.images = images
        product.inCart = inCart
        product.datumDescription = description
        return product
    }
    
    
}
