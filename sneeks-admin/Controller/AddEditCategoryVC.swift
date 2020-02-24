//
//  AddEditCategoryVC.swift
//  sneeks-admin
//
//  Created by Paul Defilippi on 1/29/20.
//  Copyright © 2020 Paul Defilippi. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEditCategoryVC: UIViewController {
    
    // Mark:- Outlets
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryImage: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addButton: UIButton!
    
    var categoryToEdit: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTapsRequired = 1
        categoryImage.isUserInteractionEnabled = true
        categoryImage.addGestureRecognizer(tap)
        
        // If we are editing, categoryToEdit != nil
        if let category = categoryToEdit {
            categoryNameTextField.text = category.name
            addButton.setTitle("Save Changes", for: .normal)
            
            if let url = URL(string: category.imgUrl) {
                categoryImage.contentMode = .scaleAspectFill
                categoryImage.kf.setImage(with: url)
            }
        }
    }

    @objc func imgTapped(imgTapped: UITapGestureRecognizer) {
        launchImgPicker()
        
    }
    
    @IBAction func addCategoryClicked(_ sender: Any) {
        uploadImageThenDocument()
        
    }
    
    func uploadImageThenDocument() {
        
        guard let image = categoryImage.image, let categoryName = categoryNameTextField.text, categoryName.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Must add category image and name")
            return
        }
        
        activityIndicator.startAnimating()
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                self.handleError(error: error, msg: "Unable to upload image")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    self.handleError(error: error, msg: "Unable to retrieve image url.")
                    return
                }
                
                guard let url = url else { return }
                print("Testing URL:", url)
                
                // Upload new category document to the Firestore categories collection.
                self.uploadDocument(url: url.absoluteString)
            }
        }
    }
    
    func uploadDocument(url: String) {
        var docRef: DocumentReference!
        var category = Category.init(name: categoryNameTextField.text!,
                                     id: "",
                                     imgUrl: url,
                                     timeStamp: Timestamp())
        
        if let categoryToEdit = categoryToEdit {
            // We are editing
            docRef = Firestore.firestore().collection("categories").document(categoryToEdit.id)
            category.id = categoryToEdit.id
        } else {
            // Creating new category
            docRef = Firestore.firestore().collection("categories").document()
            category.id = docRef.documentID
        }
        
        let data = Category.modelToData(category: category)
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, msg: "Unable to upload new category to Firestore.")
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleError(error: Error, msg: String) {
        debugPrint(error.localizedDescription)
        self.simpleAlert(title: "Error", msg: msg)
        self.activityIndicator.stopAnimating()
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
