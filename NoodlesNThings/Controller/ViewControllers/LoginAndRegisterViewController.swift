//
//  LoginAndRegisterViewController.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit

class LoginAndRegisterViewController: UIViewController {
    
    static let identifier = "LoginRegID"
    
    //MARK: - UI Outlets -
    @IBOutlet weak var loginAndRegisterButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var showRegistrationButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Class Properties -
    /**
     -isRegistered
     
     Used to check whether to register or login when user enters app (will only fire upon app's initial launch. will maintain state of user otherwise)
     */
    var isRegistered: Bool = false
    
    //MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Make Navigation Bar Perty
        customNavBar()
        
        /// Do we have a user or NOT?
        showLoginRegistrationAction()

        /// UI Styling
        loginAndRegisterButton.layer.cornerRadius = 24.0
        loginAndRegisterButton.clipsToBounds = true
        navigationItem.setHidesBackButton(false, animated: true)
        
        /// Send it!!!!
        loginAndRegisterButton.addTarget(self, action: #selector(btnLoginRegAction(sender:)), for: .touchUpInside)
    }
    
    //MARK: - Class Methods -
    
    func customNavBar() {
        self.navigationItem.largeTitleDisplayMode = .always
        navigationItem.setHidesBackButton(false, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 20.0)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                             NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 34.0)!]
        
        let backImage = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationItem.leftItemsSupplementBackButton = true
        let button = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        navigationItem.setLeftBarButton(button, animated: true)
    }
    func showRegisterVC() {
        self.navigationItem.title = "Sign Up"
        loginAndRegisterButton.setTitle("Sign Up", for: .normal)
        dontHaveAccountLabel.text = "Already have an account?"
        loginAndRegisterButton.setTitle("Login", for: .normal)
        Constant.kUserDefault.set(false, forKey: Constant.kIsUserRegistered)
        Constant.kUserDefault.synchronize()
    }
    func showLoginVC() {
        self.navigationItem.title = "Login"
        loginAndRegisterButton.setTitle("Login", for: .normal)
        dontHaveAccountLabel.text = "Don't have an account?"
        loginAndRegisterButton.setTitle("Sign Up", for: .normal)
        Constant.kUserDefault.set(true, forKey: Constant.kIsUserRegistered)
        Constant.kUserDefault.synchronize()
        
    }
    func RegisterUserWithFirebase() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        AuthService.shared.RegisterUser(email: email, password: password) { ResultWithUser in
            
            self.goToCart()
        }
    }
    
    func LoginUserWithFirebase() {
        AuthService.shared.logUserin(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error == nil {
                self.goToCart()
            } else {
                print("error:\(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func goToCart() {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    //MARK: - User Interaction -
    
    /**
     Upon login screen, if new user, present registration instead
     */
    @IBAction func toRegisterNewUser(_ sender: Any) {
        showLoginRegistrationAction()
    }
    
    
    //MARK: - Selectors -
    @objc func btnLoginRegAction(sender: UIButton) {
        self.view.endEditing(true)
        
        if isRegistered == false {
            //Login
            LoginUserWithFirebase()
        }
        else {
            //Registration
            RegisterUserWithFirebase()
        }
    }
    @objc func showLoginRegistrationAction()  {
        emailTextField.text = ""
        passwordTextField.text = ""
        isRegistered = Constant.kUserDefault.bool(forKey: Constant.kIsUserRegistered)
        isRegistered == false ? showLoginVC() : showRegisterVC()
    }
}

//MARK: - UITextFieldDelegate -
extension LoginAndRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            isRegistered == false ? LoginUserWithFirebase() : RegisterUserWithFirebase()
        }
        return true
    }
}
