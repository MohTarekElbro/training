//
//  HomeViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 31/10/2022.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    //    var presenter :ProductPresenterDelegate!
    var homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollection.delegate = nil
        categoriesCollection.dataSource = nil
        productsCollection.delegate = nil
        productsCollection.dataSource = nil
        self.categoriesCollection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        self.productsCollection.register(UINib(nibName: "ProductsCell", bundle: nil), forCellWithReuseIdentifier: "productsCell")
        self.getCategories()
        self.getProducts()
        self.design()
        homeViewModel.categories.asObservable()
            .bind(to: categoriesCollection.rx.items(cellIdentifier: "categoryCell", cellType: CollectionViewCell.self) )
        { index, element, cell in
            if(index % 3 == 0){
                cell.back.backgroundColor = UIColor(red: 1.00, green: 0.35, blue: 0.35, alpha: 0.75)
            }
            else if (index % 3 == 1){
                cell.back.backgroundColor = UIColor(red: 0.26, green: 0.91, blue: 0.48, alpha: 0.75)
            }
            else {
                cell.back.backgroundColor = UIColor(red: 0.40, green: 0.49, blue: 0.92, alpha: 0.75)
            }
            cell.backgroundImage.load(urlString: element.image)
            cell.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
            cell.category.text = element.name
            cell.layer.cornerRadius = 15
            
        }.disposed(by: disposeBag)
        
        homeViewModel.products.asObservable()
            .bind(to: productsCollection.rx.items(cellIdentifier: "productsCell", cellType: ProductsCell.self) )
        { index, prod, cell in
            cell.productImage.load(urlString: prod.image)
            cell.productImage.contentMode = UIView.ContentMode.scaleAspectFit
            let c: String = String(format: "%.2f", prod.price)
            cell.price.text = "$"+c
            cell.name.text = prod.name
            cell.layer.cornerRadius = 5
            cell.product = prod
            cell.viewController = self
        }.disposed(by: disposeBag)
        
        productsCollection.rx.itemSelected
            .subscribe(onNext: {  indexPath in
                let product = self.homeViewModel.products.value[indexPath.row]
                self.performSegue(withIdentifier: K.HomeToProduct, sender: product)
            }).disposed(by: disposeBag)
        
        
    }
    
    
    func design(){
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
        
        let cellSize = CGSize(width: self.categoriesCollection.frame.width/3, height: self.categoriesCollection.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 1.0
        categoriesCollection.setCollectionViewLayout(layout, animated: false)
        
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout2.minimumInteritemSpacing = 1.0
        layout2.scrollDirection = .vertical //.horizontal
        layout2.itemSize = CGSize(width: self.productsCollection.frame.width/2.1, height: 190)
        layout2.minimumLineSpacing = 20.0
        productsCollection.setCollectionViewLayout(layout2, animated: false)
        
    }
    
    func getCategories(){
        homeViewModel.getCategories()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if response.status == true{
                    self.homeViewModel.categories.accept(response.data!.data)
//                    self.categoriesCollection.reloadData()
                }
                
            }, onError: { error in
                print("error: \(error)")
            }).disposed(by: disposeBag)
    }
    
    func getProducts(){
        homeViewModel.getProducts()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if response.status == true{
                    self.homeViewModel.products.accept(response.data!.data)
//                    self.productsCollection.reloadData()
                }
                
            }, onError: { error in
                print("error: \(error)")
            }).disposed(by: disposeBag)
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == K.HomeToProduct) {
                if let vc = segue.destination as? ProductViewController{
                    if let product = sender as? Product{
                        vc.productViewModel.product.accept(product)
                    }
                }
            }
        }
    
    
    @IBAction func openCartButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.HomeToCart, sender: self)
    }
    
    
}

extension HomeViewController:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if(collectionView == categoriesCollection){
//            print(categories[indexPath.row])
        }
        else{

        }
        return true
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}


