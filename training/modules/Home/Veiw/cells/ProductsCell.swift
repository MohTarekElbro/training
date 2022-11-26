//
//  ProductsCell.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 01/11/2022.
//

import UIKit
import RealmSwift
import Toast_Swift
class ProductsCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    var product :Product?
    var viewController:HomeViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func FavortiePressed(_ sender: UIButton) {
        let realm = try! Realm()
        if let product = self.product{
            let productModel = ProductModel.create(id: product.id, price: product.price, oldPrice: product.oldPrice, image: product.image, name: product.name, images: product.images ?? [], inCart: product.inCart ?? false, description: product.datumDescription)
            let existingPerson = realm.object(ofType: ProductModel.self, forPrimaryKey: product.id)
            
            if existingPerson != nil {
                print("Product is allready added to favorite")
                viewController!.view.makeToast("Product is allready added to favorite")
                
            } else {
                try! realm.write{
                    realm.add(productModel , update: .all)
                }
                print("Product added to favorite")
                viewController!.view.makeToast("Product added to favorite")
            }
        }
    }
    
}
