//
//  CartViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 03/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
protocol CartViewDelegate{
    func loadCart(cartItems:Array<Cart>)
    func showCartError(message:String? , status:Bool?)
}
class CartViewController: UIViewController {
    
    
    @IBOutlet weak var cartCollection: UICollectionView!
    
    let cartViewModel = CartViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        cartCollection.register(UINib(nibName: "CartProductCell", bundle: nil), forCellWithReuseIdentifier: "CartProductCell")
        
    }
    
    func loadCart(){
        cartViewModel.loadCart()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if response.status == true{
                    self.cartViewModel.products.accept(response.data!.cartItems)
                    self.cartCollection.reloadData()
                }
                
            }, onError: { error in
                print("error: \(error)")
            }).disposed(by: disposeBag)
    }
}



extension CartViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cartViewModel.products.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
        let product = self.cartViewModel.products.value[indexPath.row].product
        cell.name.text = product.name
        cell.price.text = String(format: "%.0f", product.price)
        cell.image.load(urlString: product.image)
        return cell

    }
        
}

