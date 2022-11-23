//
//  FavoritePresenter.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 10/11/2022.
//

import Foundation
import RealmSwift

protocol FavoritePresnterDelegate{
    func getFavorites()

}
class FavoritePresenter:FavoritePresnterDelegate{
    
    let realm = try! Realm()
    
    private var favoriteViewDelegate:FavoriteViewDelegate?
    init(viewDelegate:FavoriteViewDelegate){
        self.favoriteViewDelegate = viewDelegate
    }
    
    func getFavorites(){
        let data = realm.objects(ProductModel.self)
        print(data)
        favoriteViewDelegate?.loadFavorites(favorites: data)
    }
    
}

