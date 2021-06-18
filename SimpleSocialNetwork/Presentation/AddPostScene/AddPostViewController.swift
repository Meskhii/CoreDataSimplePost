//
//  AddPostViewController.swift
//  SimpleSocialNetwork
//
//  Created by user200328 on 6/18/21.
//

import UIKit
import CoreData

class AddPostViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    
    // MARK: - Variables
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    private var coreDataManager: CoreDataManagerProtocol!
    var user: User?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataManager = CoreDataManager()
    }
    
    // MARK: - IBActions
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        if checkInputs() {
                savePost()
        } else {
            showAlert(with: "Fill All Fields, or Choose Image")
        }
    }
    
    @IBAction func imagePickerTapped(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true)
    }
    
    // MARK: - Sending Email
    private func savePost() {
        guard let context = context else { return }
        guard let imageData = getImageData() else {return}
        
        let post = Post(context: context)
        post.title = titleTextField.text!
        post.postDescription = postDescriptionTextView.text!
        post.image = imageData
        
        user?.addToCreatedPosts(post)
        
        coreDataManager.savePost(with: post) { success in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showAlert(with: "Unknown Error")
            }
        }
    }
    
    private func getImageData() -> Data? {
        
        if let jpegData = imageView.image?.jpeg {
            return jpegData
        }
        
        if let pngData = imageView.image?.png {
            return pngData
        }
        
        return nil
    }
    
    // MARK: - Field Validation
    private func checkInputs() -> Bool {
        return titleTextField.hasText || postDescriptionTextView.hasText || imageView != nil
    }
    
    private func showAlert(with message: String) {
         
         let alert = UIAlertController(title: "Error",
                                       message: message,
                                       preferredStyle: .alert)

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

         self.present(alert, animated: true)
     }
    
}

// MARK: - Image Picker Delegate & NavController Delegate
extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
}
