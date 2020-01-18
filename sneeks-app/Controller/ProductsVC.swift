//
//  ProductsVC.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/15/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductsVC: UIViewController {
    
    // MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    
    var products = [Product]()
    var category: Category!
    
    override func viewDidLoad() {
        
        let product = Product.init(name: "Hot Kicks", id: "qergbq", category: "High Tops", price: 127.99, productDescription: "Get em while there hot", imageUrl: "https://images.unsplash.com/photo-1558191053-c03db2757e3d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3750&q=80", timeStamp: Timestamp(), stock: 0, favorite: false)
        products.append(product)
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCell)
    }
}

extension ProductsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
