//
//  SignUpViewController.swift
//  SimpleSocialNetwork
//
//  Created by Admin on 17.06.2021.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Variables
    private var coreDataManager: CoreDataManagerProtocol!
    
    // MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coreDataManager = CoreDataManager()
    }

    @IBAction func signUpUser(_ sender: Any) {
        if checkInputs() {
            if registerUser() {
                popToWelcomePage()
            } else {
                showAlert(with: "Registration Error")
            }
        } else {
            showAlert(with: "Feel All Fields")
        }
    }
    
    // MARK: - Registration Validations
    private func checkInputs() -> Bool {
        return emailTextField.hasText || passwordTextField.hasText
    }
    
    private func registerUser() -> Bool {
        var registrationSuccess = false
        coreDataManager.register(with: emailTextField.text!, and: passwordTextField.text!) { success in
            registrationSuccess = success
        }
        return registrationSuccess
    }
    
    private func showAlert(with message: String) {
         
         let alert = UIAlertController(title: "Error",
                                       message: message,
                                       preferredStyle: .alert)

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

         self.present(alert, animated: true)
     }
     
     // MARK: - Navigation Method
     private func popToWelcomePage(){
        self.navigationController?.popViewController(animated: true)
     }

}
