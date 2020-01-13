//
//  ViewController.swift
//  sneeks-app
//
//  Created by Paul Defilippi on 1/8/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    // MARK:- Outlets

    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
            // We are logged in
            loginOutBtn.title = "Logout"

        } else {
            loginOutBtn.title = "Login"
        }
    }
    
    // MARK:- Actions

    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }

    @IBAction func loginOutClicked(_ sender: Any) {
        if let _ = Auth.auth().currentUser {
            // We are logged in
            do {
                try Auth.auth().signOut()
                presentLoginController()
            } catch {
                debugPrint(error.localizedDescription)
            }

        } else {
            presentLoginController()
        }
    }
    
}

