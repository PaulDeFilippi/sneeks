//
//  AddEditProductsVC.swift
//  sneeks-admin
//
//  Created by Paul Defilippi on 2/2/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import FirebaseStorage

class AddEditProductsVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var productNameText: UITextField!
    @IBOutlet weak var productPriceText: UITextField!
    @IBOutlet weak var productDescText: UITextView!
    @IBOutlet weak var productImgView: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: RoundedButton!
    
    // MARK:- Properties
    var selectedCategory: Category!
    var productToEdit: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTapsRequired = 1
        productImgView.isUserInteractionEnabled = true
        productImgView.addGestureRecognizer(tap)

    }
    
    @objc func imgTapped() {
        launchImgPicker()
    }
    
    @IBAction func addClicked(_ sender: Any) {
        uploadImageThenDocument()
        
    }
    
    func uploadImageThenDocument() {
        guard let image = productImgView.image,
            let name = productNameText.text, name.isNotEmpty,
            let description = productDescText.text, description.isNotEmpty,
            let priceString = productPriceText.text,
            let price = Double(priceString) else {
                simpleAlert(title: "Missing Fields", msg: "Please fill out all required fields.")
                return
        }
        
        activityIndicator.startAnimating()
        
        // Step 1: Turn image into data
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        // Step 2: Create a storage image reference. Alocation in Firestorage for it to be stored.
        let imageRef = Storage.storage().reference().child("/productImages/\(name).jpg")
        
        // Step 3: Set the metadata
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Step 4: Upload the data
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            
            if let error = error {
                self.handleError(error: error, msg: "Unable to upload image.")
                return
            }
            
            // Step 5: Once the image is uploaded, retrieve the download URL.
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    self.handleError(error: error, msg: "Unable to download url.")
                    return
                }
                
                guard let url = url else { return }
                print(url)
                // Step 6: Upload new Product document to the Firestore products collection.
            }
            
        }
        
        
        
    }
    
    func uploadDocument() {
        
    }
    
    func handleError(error: Error, msg: String) {
        debugPrint(error.localizedDescription)
        self.simpleAlert(title: "Error", msg: msg)
        self.activityIndicator.stopAnimating()
    }
}

extension AddEditProductsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImgPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        guard let image = info[.originalImage] as? UIImage else { return }
        productImgView.contentMode = .scaleAspectFill
        productImgView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
