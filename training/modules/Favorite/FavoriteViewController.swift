//
//  FavoriteViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 10/11/2022.
//

import UIKit
import RealmSwift

protocol FavoriteViewDelegate{
    func loadFavorites(favorites:Results<ProductModel>)
    func showFavoriteError(message:String? , status:Bool?)
}

class FavoriteViewController: UIViewController {
    var favorites : Results<ProductModel>?

    @IBOutlet weak var favoriteCollection: UICollectionView!
    @IBOutlet weak var favoriteLabel: UILabel!
    var presenter :FavoritePresnterDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollection.register(UINib(nibName: "CartProductCell", bundle: nil), forCellWithReuseIdentifier: "CartProductCell")
        presenter = FavoritePresenter(viewDelegate: self)
        presenter.getFavorites()
    }
    
}

extension FavoriteViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(favorites?.count)
        if let count = favorites?.count{
            
            print(count)
            return count
        }
        else{
            favoriteLabel.text = "No Favorites yet"
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
        if let product = favorites?[indexPath.row]{
            cell.name.text = product.name
            cell.price.text = String(format: "%.0f", product.price)
            cell.image.load(urlString: product.image)
        }
        return cell

    }
        
}

extension FavoriteViewController:FavoriteViewDelegate{
    func loadFavorites(favorites: RealmSwift.Results<ProductModel>) {
        self.favorites = favorites
        favoriteCollection.reloadData()
    }
    
    func showFavoriteError(message: String?, status: Bool?) {
        if let msg = message{
            print(message!)
            self.showToast(msg)
        }
    }
    
}
