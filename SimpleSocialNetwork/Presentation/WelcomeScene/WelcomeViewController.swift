//
//  WelcomeViewController.swift
//  SimpleSocialNetwork
//
//  Created by Admin on 17.06.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }

    
    @IBAction func signUpPressed(_ sender: Any) {
        navigateTo(vcId: VCIds.signUpVC)
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        navigateTo(vcId: VCIds.loginVC)
    }
    
    private func navigateTo(vcId: String) {
        let sb = UIStoryboard(name: vcId, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcId)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
