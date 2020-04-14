//
//  CartItemCell.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 4/11/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit

protocol CartItemDelegate: class {
    func removeItem(product: Product)
}

class CartItemCell: UITableViewCell {
    
    @IBOutlet weak var productImg: RoundedImageView!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var removeItemBtn: UIButton!
    
    // MARK:- Properties
    
    private var item: Product!
    weak var delegate: CartItemDelegate?
    
    // MARK:- Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK:- Actions

    func configureCell(product: Product, delegate: CartItemDelegate) {
        self.delegate = delegate
        self.item = product

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let price = formatter.string(from: product.price as NSNumber) {
            productTitleLbl.text = "\(product.name) \(price)"
        }
        
        if let url = URL(string: product.imageUrl) {
            productImg.kf.setImage(with: url)
        }
    }
    
    @IBAction func removeItemClicked(_ sender: Any) {
        delegate?.removeItem(product: item)
        
    }
    
}
