//
//  CartProductCell.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 03/11/2022.
//

import UIKit

class CartProductCell: UICollectionViewCell {
    
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        ContainerView.layer.shadowColor = UIColor.gray.cgColor
        ContainerView.layer.shadowOpacity = 0.3
        ContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0);
        ContainerView.layer.shadowRadius = 10
        //        ContainerView.backgroundColor = UIColor.lightGray
        // Initialization code
    }
    
    @IBAction func minusCount(_ sender: Any) {
        var i = Int(count.text!)
        if(i! > 0){
            i=i!-1
            count.text = String(i!)
        }
    }
    
    @IBAction func plusCount(_ sender: UIButton) {
        var i = Int(count.text!)
        if(i! < 10){
            i=i!+1
            count.text = String( i!)
        }
    }
}
