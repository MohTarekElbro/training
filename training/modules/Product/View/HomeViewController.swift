//
//  HomeViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 31/10/2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var presenter :ProductPresenterDelegate!
    
    var token = ""
    
    
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    var categories = Array<Category>()
    var products = Array<Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProductPresenter(productViewDelegate: self)
        
        searchBar.tintColor = UIColor.gray
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true;
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBarView.layer.shadowColor = UIColor.gray.cgColor
        searchBarView.layer.shadowOpacity = 0.4
        searchBarView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0);
        searchBarView.layer.shadowRadius = 15
        categoriesCollection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        productsCollection.register(UINib(nibName: "ProductsCell", bundle: nil), forCellWithReuseIdentifier: "productsCell")
        self.presenter.getProducts(token: self.token)
        self.presenter.getCategories()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu Bar"), style: .done, target: self, action: #selector(self.backAction(sender:)))
    }
    
    @objc func backAction(sender: AnyObject) {
        print("hey baaack")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.HomeToProduct) {
            if let vc = segue.destination as? ProductViewController{
                if let product = sender as? Product{
                    vc.product = product
                    vc.token = token
                }
            }
        }
        else if (segue.identifier == K.HomeToCart) {
            if let vc = segue.destination as? CartViewController{
                vc.token = token
            }
        }
    }
    
    
    @IBAction func openCartButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.HomeToCart, sender: self)
        
    }
    
    
}

extension HomeViewController:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == categoriesCollection){
            return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
        }
        else{
            return CGSize(width: collectionView.frame.width/2.1, height: 190)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == categoriesCollection){
            return categories.count
        }
        else{
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if(collectionView == categoriesCollection){
            print(categories[indexPath.row])
        }
        else{
            let product = products[indexPath.row]
            performSegue(withIdentifier: K.HomeToProduct, sender: product)
            
        }
        return true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == categoriesCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CollectionViewCell
            let cate = categories[indexPath.row]
            if(indexPath.row % 3 == 0){
                cell.back.backgroundColor = UIColor(red: 1.00, green: 0.35, blue: 0.35, alpha: 0.75)
            }
            else if (indexPath.row % 3 == 1){
                cell.back.backgroundColor = UIColor(red: 0.26, green: 0.91, blue: 0.48, alpha: 0.75)
            }
            else {
                cell.back.backgroundColor = UIColor(red: 0.40, green: 0.49, blue: 0.92, alpha: 0.75)
            }
            cell.backgroundImage.load(urlString: cate.image)
            cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
            cell.category.text = cate.name
            cell.layer.cornerRadius = 15
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! ProductsCell
            let prod = products[indexPath.row]
            cell.productImage.load(urlString: prod.image)
            cell.productImage.contentMode = UIView.ContentMode.scaleAspectFit
            let c: String = String(format: "%.2f", prod.price)
            cell.price.text = "$"+c
            cell.name.text = prod.name
            cell.layer.cornerRadius = 5
            cell.product = prod
            cell.viewController = self
            return cell
        }
    }
}

extension HomeViewController:ProductViewDelegate{
    func loadCategories(categories: Array<Category>) {
        self.categories = categories
        categoriesCollection.reloadData()
    }
    
    func openCart() {
        return
    }
    
    func loadProducts(products: Array<Product>) {
        self.products = products
        productsCollection.reloadData()
    }
    
    func showProductError(message: String?, status: Bool?) {
        print(message!)
        if let msg = message{
            self.showToast(msg)
        }
    }
}

extension UIImageView {
    func load( urlString:String) {
        let url = URL(string: urlString)
        self.kf.setImage(with: url)
    }
}
