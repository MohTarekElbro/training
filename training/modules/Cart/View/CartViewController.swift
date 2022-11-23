//
//  CartViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 03/11/2022.
//

import UIKit

protocol CartViewDelegate{
    func loadCart(cartItems:Array<Cart>)
    func showCartError(message:String? , status:Bool?)
}
class CartViewController: UIViewController {
    
    
    @IBOutlet weak var cartCollection: UICollectionView!
    var presenter: CartPresenterDelegate!
    
    var cartItems = Array<Cart>()
    var token = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = CartPresenter(viewDelegate: self)
        cartCollection.register(UINib(nibName: "CartProductCell", bundle: nil), forCellWithReuseIdentifier: "CartProductCell")
        
        self.presenter.getCart(token: token)
    }

}

extension CartViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
        let product = cartItems[indexPath.row].product
        cell.name.text = product.name
        cell.price.text = String(format: "%.0f", product.price)
        cell.image.load(urlString: product.image)
        return cell

    }
        
}

extension CartViewController:CartViewDelegate{
    func loadCart(cartItems: Array<Cart>) {
        self.cartItems = cartItems
        cartCollection.reloadData()
    }
    
    func showCartError(message: String?, status: Bool?) {
        if let msg = message{
            print(message!)
            self.showToast(msg)
        }
    }
    
   
    
    
}
