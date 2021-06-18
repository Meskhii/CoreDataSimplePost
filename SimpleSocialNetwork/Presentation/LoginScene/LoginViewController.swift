//
//  LoginViewController.swift
//  SimpleSocialNetwork
//
//  Created by Admin on 17.06.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Variables
    private var coreDataManager: CoreDataManagerProtocol!

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false

        coreDataManager = CoreDataManager()
    }
    
    @IBAction func loginUser(_ sender: Any) {
        if checkInputs() {
            loginUser()
        } else {
            showAlert(with: "Feel All Fields")
        }
    }
    
    // MARK: - Registration Validations
    private func checkInputs() -> Bool {
        return emailTextField.hasText || passwordTextField.hasText
    }
    
    private func loginUser() {
        coreDataManager.login(with: emailTextField.text!, and: passwordTextField.text!) { result in
            switch result {
            case .success(let user):
                guard let user = user else {return}
                self.navigateToEmail(with: user)
            case .failure(let error):
                self.showAlert(with: "\(error)")
            }
        }
     
    }
    
    private func showAlert(with message: String) {
         
         let alert = UIAlertController(title: "Error",
                                       message: message,
                                       preferredStyle: .alert)

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

         self.present(alert, animated: true)
     }
     
     // MARK: - Navigation Method
    private func navigateToEmail(with user: User) {
        let sb = UIStoryboard(name: VCIds.postsVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.postsVC) as! PostsViewController
        
        vc.user = user
        
        self.navigationController?.setViewControllers([vc], animated: true)
     }
    
}
