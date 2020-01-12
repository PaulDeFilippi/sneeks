//
//  RegisterVC.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/12/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    // Outlets
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        confirmPasswordTxt.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let passTxt = passwordTxt.text else { return }
        
        if textField == confirmPasswordTxt {
            passCheckImg.isHidden = false
            confirmPassCheckImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPasswordTxt.text = ""
            }
        }
        
        if passwordTxt.text == confirmPasswordTxt.text {
            passCheckImg.image = UIImage(named: "green_check")
            confirmPassCheckImg.image = UIImage(named: "green_check")
        } else {
            passCheckImg.image = UIImage(named: "red_check")
            confirmPassCheckImg.image = UIImage(named: "red_check")
        }
        
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
        guard let username = usernameTxt.text, username.isNotEmpty,
            let email = emailTxt.text, email.isNotEmpty,
            let password = passwordTxt.text, password.isNotEmpty else { return }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                debugPrint(error)
                return
            }
            
            self.activityIndicator.stopAnimating()
            print("successfully registered new user.")
            
        }
        
    }
    

}
