//
//  ProductViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 02/11/2022.
//

import UIKit
import RxCocoa
import RxSwift
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

    var productViewModel = ProductViewModdel()
    var counter = 0
    
    @IBOutlet weak var addToCartButton: UIButton!
    let disposeBag = DisposeBag()
    var images = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
    }
    
    func showData(){
        if let product = self.productViewModel.product.value{
            if (product.inCart == true ){
                addToCartButton.isHidden = true
            }
            images = product.images!
            pageControl.numberOfPages = images.count
            pageControl.currentPage = 0
            pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .menuActionTriggered)
            name.text = product.name
            price.text = "$"+String(format: "%.0f", product.price/100)
            desc.text = product.datumDescription
            imagesSliderCollection.reloadData()
        }
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
        if (self.productViewModel.product.value?.inCart == false ){
            self.productViewModel.addToCart()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    if response.status == true{
                        self.performSegue(withIdentifier: K.ProductToCart, sender: self)
                    }
                    
                }, onError: { error in
                    print("error: \(error)")
                }).disposed(by: disposeBag)
        }
    }
    
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
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


