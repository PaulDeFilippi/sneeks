//
//  ProductDetailVC.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/27/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productTitle.text = product.name
        productDescription.text = product.productDescription
        
        if let url = URL(string: product.imageUrl) {
            productImg.kf.setImage(with: url)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProductView))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func dismissProductView() {
        dismiss(animated: true, completion: nil)

    }

    @IBAction func addToCartClicked(_ sender: Any) {
        if UserService.isGuest {
            self.simpleAlert(title: "Hi friend!", msg: "This feature is for registered users only. Please create a registered account to use add to cart feature.")
            return
        }

        // add product to cart
        StripeCart.addItemToCart(item: product)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func dismissProduct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
