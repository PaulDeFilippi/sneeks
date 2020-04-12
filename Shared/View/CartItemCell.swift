//
//  CartItemCell.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 4/11/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    
    @IBOutlet weak var productImg: RoundedImageView!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var removeItemBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeItemClicked(_ sender: Any) {
        
    }
    
}
