//
//  ViewController.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 27/10/2022.
//

import UIKit
import IQKeyboardManagerSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var signInbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signInbutton.addBottomShadow()
        let imgBack = UIImage(systemName: "arrow.backward")
        navigationController?.navigationBar.backIndicatorImage = imgBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false

    }
}
extension UIView{
    func addBottomShadow(){
        layer.shadowColor = UIColor.blue.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.0, height: 10.0);
        layer.shadowRadius = 4
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 112).cgPath
    }
}

extension UIViewController {

func showToast(_ message : String) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

