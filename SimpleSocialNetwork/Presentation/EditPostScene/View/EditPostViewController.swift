//
//  EditPostViewController.swift
//  SimpleSocialNetwork
//
//  Created by user200328 on 6/18/21.
//

import UIKit
import CoreData

class EditPostViewController: UIViewController {
    
    // MARK: - Variables
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    private var coreDataManager: CoreDataManagerProtocol!
    private var postsList = [Post]()
    var postIndex = Int()
    private var viewModel: EditPostViewModelProtocol?
    var user: User?
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        fetchAllPosts()
        
    }
    
    // MARK: - Setupers
    private func setupPostToEdit() {
        titleTextField.text = postsList[postIndex].title
        postDescriptionTextView.text = postsList[postIndex].postDescription
        imageView.image = postsList[postIndex].image?.uiImage
    }
    
    private func configureViewModel() {
        viewModel = EditPostViewModel(with: CoreDataManager())
    }
    
    func fetchAllPosts() {
        viewModel?.fetchAllPosts() { posts in
            self.postsList = posts
            self.setupPostToEdit()
            
        }
    }
    
    // MARK: - IBActions
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if checkInputs() {
            updatePost()
            self.navigationController?.popViewController(animated: true)
        } else {
            showAlert(with: "Fill All Fields, or Choose Image")
        }
    }
    
    
    @IBAction func deletePostTapped(_ sender: Any) {
        let postToRemove = postsList[postIndex]
        context?.delete(postToRemove)
        
        do {
            try context?.save()
        } catch {
            print(error)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imagePicker(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true)
    }
    
    // MARK: - Sending Email
    private func updatePost() {
        guard let imageData = getImageData() else {return}
        
        let postToUpdate = postsList[postIndex]
        postToUpdate.image = imageData
        postToUpdate.title = titleTextField.text!
        postToUpdate.postDescription = postDescriptionTextView.text!
        
        do {
            try context?.save()
        } catch {
            print(error)
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
extension EditPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
}
