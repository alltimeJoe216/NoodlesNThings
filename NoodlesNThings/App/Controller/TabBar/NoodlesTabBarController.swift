//
//  NoodlesTabBarController.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit
import Firebase

class NoodlesTabBarController: UITabBarController {
    
    var user = AuthService.shared.user

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
     
    }
    
    private func authenticateUser() {
        if let authUser = Auth.auth().currentUser {
            if AuthService.shared.user == nil {
                let noodleUser = NoodleUser(id: authUser.uid, email: authUser.email)
                AuthService.shared.user = noodleUser
            }
        } else {
            DispatchQueue.main.async {
                guard let onboard = self.storyboard?.instantiateViewController(identifier: OnboardViewController.identifier) else { return }
                
                onboard.modalPresentationStyle = .fullScreen
                self.present(onboard, animated: true, completion: nil)
            }
        }
    }

}
