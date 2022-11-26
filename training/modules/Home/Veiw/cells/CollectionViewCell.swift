//
//  CollectionViewCell.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 31/10/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}
