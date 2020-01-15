//
//  ForgotPasswordVC.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/14/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    // MARK:- Outlets

    @IBOutlet weak var emailText: UITextField!
    
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK:- Actions

    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        
        guard let email = emailText.text, email.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please enter email address that was used for creating account.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            print("Password reset was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
