//
//  ViewController.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/8/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomeVC: UIViewController {
    
    // MARK:- Outlets

    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK:- Properties
    
    var categories = [Category]()
    var selectedCategory: Category!
    var db: Firestore!
    var listener: ListenerRegistration!
    
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        // dummy data
//        let category = Category.init(name: "Jordans", id: "12344", imgUrl: "https://images.unsplash.com/photo-1560906992-4b00de401b90?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80", isActive: true, timeStamp: Timestamp())
//        categories.append(category)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                    debugPrint(error)
                    return
                }
            }
        }

    }
    
    func fetchDocument() {
        let docRef = db.collection("categories").document("SCL292LvBlpqIvY0EYyb")
        
        // with snapshot listener for data change to document
        listener = docRef.addSnapshotListener { (snap, error) in
            self.categories.removeAll()
            guard let data = snap?.data() else { return }
            let newCategory = Category.init(data: data)
            self.categories.append(newCategory)
            self.collectionView.reloadData()
        }
        
//        docRef.getDocument { (snap, error) in
//            guard let data = snap?.data() else { return }
//            let newCategory = Category.init(data: data)
//            self.categories.append(newCategory)
//            self.collectionView.reloadData()
//        }
    }
    
    func fetchCollection() {
        let collectionReference = db.collection("categories")
        
        // with snapshot listener added to listen for data changes to entire collection
        listener = collectionReference.addSnapshotListener { (snap, error) in
            self.categories.removeAll()
            guard let documents = snap?.documents else { return }
            for document in documents {
                let data = document.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            self.collectionView.reloadData()
        }
        
//        collectionReference.getDocuments { (snap, error) in
//            guard let documents = snap?.documents else { return }
//            for document in documents {
//                let data = document.data()
//                let newCategory = Category.init(data: data)
//                self.categories.append(newCategory)
//            }
//            self.collectionView.reloadData()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //fetchDocument()
        fetchCollection()
        
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            // We are logged in
            loginOutBtn.title = "Logout"

        } else {
            loginOutBtn.title = "Login"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
    }
    
    // MARK:- Actions

    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }

    @IBAction func loginOutClicked(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    
                    if let error = error {
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                        debugPrint(error)
                        
                    }
                    self.presentLoginController()
                }
            } catch {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                debugPrint(error)
            }
        }
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 30) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segues.ToProducts, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToProducts {
            if let destination = segue.destination as? ProductsVC {
                destination.category = selectedCategory
            }
        }
    }
}

