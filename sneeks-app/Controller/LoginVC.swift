//
//  LoginVC.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/12/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func forgotPassClicked(_ sender: Any) {
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text, email.isNotEmpty,
            let password = passTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
                
        }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in

            if let error = error {
                debugPrint(error.localizedDescription)
                self.handleFireAuthError(error: error)
                self.activityIndicator.stopAnimating()
                return
            }
            
            print("Login was successful.")
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func guestClicked(_ sender: Any) {
    }
    
}
