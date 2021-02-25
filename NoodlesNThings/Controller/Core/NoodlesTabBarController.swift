//
//  NoodlesTabBarController.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit
import Firebase

class NoodlesTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AuthService.shared.signOut
        
    }
    
    private func authenticateUser() {
        if let authUser = Auth.auth().currentUser {
            if AuthService.shared.user == nil {
                let fameUser = NoodleUser(id: authUser.uid, email: authUser.email)
                AuthService.shared.user = fameUser
            }
        } else {
            DispatchQueue.main.async {
                guard let loginVC = self.storyboard?.instantiateViewController(identifier: OnboardViewController.identifier) else { return }
                
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        }
    }

}
