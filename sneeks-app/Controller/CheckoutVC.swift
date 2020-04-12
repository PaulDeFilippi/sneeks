//
//  CheckoutVC.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 4/11/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var paymentMethodBtn: UIButton!
    
    @IBOutlet weak var shippingMethodBtn: UIButton!
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var processingFeeLbl: UILabel!
    @IBOutlet weak var shippingCostLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func placeOrderClicked(_ sender: Any) {
        
    }
    
    @IBAction func paymentMethodClicked(_ sender: Any) {
        
    }
    
    @IBAction func shippingMethodClicked(_ sender: Any) {
        
    }
}
