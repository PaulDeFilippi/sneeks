//
//  UserService.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 4/7/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    
    // MARK:- Properties

    var user = User()
    var favorites = [Product]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener: ListenerRegistration? = nil
    var favsListener: ListenerRegistration? = nil
    
    var isGuest: Bool {
        guard let authUser = auth.currentUser else {
            return true
        }
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
        // MARK:- Actions

    func getCurrentUser() {
        guard let authUser = auth.currentUser else { return }
        
        let userRef = db.collection("users").document(authUser.uid)
        userListener = userRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
            print("THIS IS THE USER ON LAUNCH: \(self.user)")
        })
        
        let favsRef = userRef.collection("favorites")
        favsListener = favsRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favorite = Product.init(data: document.data())
                self.favorites.append(favorite)
            })
        })
    }
    
    func favoriteSelected(product: Product) {
        let favsRef = Firestore.firestore().collection("users").document(user.id).collection("favorites")
        
        if favorites.contains(product) {
            // We remove it as a favorite
            favorites.removeAll{ $0 == product }
            favsRef.document(product.id).delete()
        } else {
            // Add as a favorite
            favorites.append(product)
            let data = Product.modelToData(product: product)
            favsRef.document(product.id).setData(data)
        }
        
    }
    
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        favsListener = nil
        user = User()
        favorites.removeAll()
    }
}