//
//  FavoritePresenter.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 10/11/2022.
//

import Foundation
import RealmSwift
import RxRealm
import RxCocoa
import RxSwift


class FavoriteViewModel{
    let realm = try! Realm()
//    let products = BehaviorRelay<[ProductModel]>(value: Array<ProductModel>())
    var favorites: Observable<Results<ProductModel>> {
        return Observable<Results>.collection(from: realm.objects(ProductModel.self))
    }
    
   
    
}

