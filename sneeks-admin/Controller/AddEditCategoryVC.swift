//
//  AddEditCategoryVC.swift
//  sneeks-admin
//
//  Created by Paul Defilippi on 1/29/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit

class AddEditCategoryVC: UIViewController {
    
    // Mark:- Outlets
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryImage: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTapsRequired = 1
        categoryImage.isUserInteractionEnabled = true
        categoryImage.addGestureRecognizer(tap)
    }

    @objc func imgTapped(imgTapped: UITapGestureRecognizer) {
        launchImgPicker()
        
    }
    
    @IBAction func addCategoryClicked(_ sender: Any) {
        
    }
    
}

extension AddEditCategoryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImgPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        categoryImage.contentMode = .scaleAspectFill
        categoryImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
