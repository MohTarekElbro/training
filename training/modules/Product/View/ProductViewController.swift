//
//  ProductViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 02/11/2022.
//

import UIKit
protocol ProductViewDelegate{
    func loadCategories(categories:Array<Category>)
    func loadProducts(products:Array<Product>)
    func showProductError(message:String? , status:Bool?)
    func openCart()
}

class ProductViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var descHeight: NSLayoutConstraint!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var imagesSliderCollection: UICollectionView!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var product: Product?
    
    var timer = Timer()
    var counter = 0
    var token = ""
    
    @IBOutlet weak var addToCartButton: UIButton!
    var presenter :ProductPresenterDelegate!
    
    var images = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (product?.inCart == true ){
            print("ProductInCart")
            addToCartButton.isHidden = true
        }
        self.presenter = ProductPresenter(productViewDelegate: self)
        images = product!.images!
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .menuActionTriggered)
        name.text = product!.name
        price.text = "$"+String(format: "%.0f", product!.price/100)
        desc.text = product!.datumDescription
        
    }
    
    @IBAction func morePressed(_ sender: UIButton) {
        if desc.numberOfLines == 6{
            desc.numberOfLines = 0
            moreButton.setTitle("Less", for: .normal)
            
        }
        else{
            desc.numberOfLines = 6
            moreButton.setTitle("More", for: .normal)
            
        }
    }
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        if (product?.inCart == false ){
            self.presenter.addProductToCart(token: token, product_id: product!.id)
        }
    }
    
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
        print("pageControlSelectionAction: \(sender.currentPage)")
        let page: Int? = sender.currentPage
        
        let index = IndexPath(item: page!, section: 0)
        imagesSliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    
    @objc func slide(){
        let index = IndexPath(item: counter, section: 0)
        if counter < images.count{
            imagesSliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }
        else{
            counter = 0
            imagesSliderCollection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
            counter = 1
        }
        pageControl.currentPage = counter
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / self.imagesSliderCollection.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
    
    
}

extension ProductViewController:ProductViewDelegate{
    func loadCategories(categories: Array<Category>) {
        return
    }
    
    func openCart() {
        performSegue(withIdentifier: K.ProductToCart, sender: self)
    }
    
    func loadProducts(products: Array<Product>) {
       return
    }
    
    func showProductError(message: String?, status: Bool?) {
        print(message!)
        if let msg = message{
            self.showToast(msg)
        }
    }
}

extension ProductViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSliderCell", for: indexPath) as! ProductSliderCell
        cell.image.load(urlString: images[indexPath.row])
        cell.image.contentMode = UIView.ContentMode.scaleAspectFill
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}


