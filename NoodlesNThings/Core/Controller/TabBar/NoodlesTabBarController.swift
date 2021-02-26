//
//  NoodlesTabBarController.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit
import Firebase

class NoodlesTabBarController: UITabBarController {
    
    //MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
    }
    
    //MARK: - Authenticate User -
    // Check if FB user is authenticated, if so, set Fb current user to AuthService.shared.user (Noodle User), otherwise, direct to registration/login
    private func authenticateUser() {
        if let authUser = Auth.auth().currentUser {
            if AuthService.shared.user == nil {
                let noodleUser = NoodleUser(id: authUser.uid, email: authUser.email)
                AuthService.shared.user = noodleUser /// Noodle user == Fb current user.
                print("Signed in with user with ID of: \(String(describing: AuthService.shared.user?.id))") }}
        else { DispatchQueue.main.async { /// Send to reg/login
                guard let onboard = self.storyboard?.instantiateViewController(identifier: OnboardViewController.identifier) else { return }
                onboard.modalPresentationStyle = .fullScreen
                self.present(onboard, animated: true, completion: nil)
            }
        }
    }
}
