//
//  FavoriteViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 10/11/2022.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa



class FavoriteViewController: UIViewController {
    var favorites : Results<ProductModel>?
    let disposeBag = DisposeBag()

    @IBOutlet weak var favoriteCollection: UICollectionView!
    @IBOutlet weak var favoriteLabel: UILabel!
    var presenterViewModel = FavoriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollection.delegate = nil
        favoriteCollection.dataSource = nil
        favoriteCollection.register(UINib(nibName: "CartProductCell", bundle: nil), forCellWithReuseIdentifier: "CartProductCell")
        
        let cellSize = CGSize(width: favoriteCollection.frame.width, height: 160)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 1.0
        favoriteCollection.setCollectionViewLayout(layout, animated: false)
        
        self.presenterViewModel.favorites
            .bind(to: favoriteCollection.rx.items(cellIdentifier: "CartProductCell", cellType: CartProductCell.self) )
        { index, product, cell in
            
            cell.name.text = product.name
            cell.price.text = String(format: "%.0f", product.price)
            cell.image.load(urlString: product.image)
            
        }.disposed(by: disposeBag)
    }
    
}

extension FavoriteViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()

    }
        
}


