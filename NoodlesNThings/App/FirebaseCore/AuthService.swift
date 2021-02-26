//
//  AuthService.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import Foundation
import Firebase
import FirebaseAuth

/// - Usage
/// ```
/// complete(.success(Void())
/// ```
/// - Callee example
/// ```
/// switch result {
///     case .success:
///       print("success")
///     case .failure(let error):
///       print(error)
/// }
/// ```
typealias CompleteVoid = (Result<Void, Error>) -> Void

//TODO: Create own file for error handler
enum AuthErrorHandler: NoodlesErrorProtocol {
    case unknown(domain: String, description: String = "An unknown Error Occurred.")
    case notSignedIn(domain: String, description: String = "The user wasn't signed in")
    
    var nsError: NSError {
        switch self {
        case .unknown(let domain, let description):
            return NSError(domain: domain, code: 999, userInfo: ["NSLocalizedDescriptionKey": description])
        case .notSignedIn(domain: let domain, description: let description):
            return NSError(domain: domain, code: 999, userInfo: ["NSLocalizedDescriptionKey": description])
        }
    }
}

class AuthService {
    
    // MARK: - Singleton -
    static let shared = AuthService()
    
    private init() { }
    
    //MARK: - Class Properties -
    let log = OSLog(AuthService.self, category: "Singleton_ModelController_Firebase_Auth")
    let databaseService = DatabaseService()
    var user: NoodleUser?
    
    // MARK: - Register -
    /// Register a Firebase user and save their details in the realtime database
    /// - Parameters:
    ///   - username: Used to link Auth user to app user
    func RegisterUser(email: String, password: String, completion: @escaping ResultWithUser) {
        Auth.auth().createUser(withEmail: email, password: password) { (firebaseAuthResult, error) in
            if let error = error {
                print("Error registering user: \(error)")
                completion(.failure(error))
                self.log.error("Error creating User: %@", error.localizedDescription)
                self.log.trace()
                return
            }
            
            guard let firebaseAuthResult = firebaseAuthResult else {
                let error = AuthErrorHandler.unknown(domain: "\(#file).\(#function)").nsError
                completion(.failure(error))
                self.log.error("Error creating User: %@", error.localizedDescription)
                self.log.trace()
                return
            }
            
            let user = NoodleUser(id: firebaseAuthResult.user.uid, email: email)
            self.databaseService.createUser(user: user) { (dbResult) in
                // normally we could just bubble the result, but we want the user from it to assign here.
                switch dbResult {
                case .success(let user):
                    self.user = user
                    completion(.success(user))
                // log.info notice posted in DatabaseService.swift
                case .failure(let error):
                    completion(.failure(error))
                    self.log.error("Error creating User: %@", error.localizedDescription)
                    self.log.trace()
                }
            }
        }
    }
    
    // MARK: - Login -
    func logUserin(withEmail email: String, password: String, completion: @escaping AuthDataResultCallback) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(result, error)
                self.log.error("Error logging user in: %@", error.localizedDescription)
                self.log.trace()
                return
            }
            
            guard let authResult = result else {
                let error = AuthErrorHandler.unknown(domain: "\(#file).\(#function)").nsError
                completion(result, error)
                self.log.error("Error logging user in: %@", error.localizedDescription)
                self.log.trace()
                return
            }
            
            self.user = NoodleUser(id: authResult.user.uid, email: authResult.user.email)
            completion(result, error)
        }
    }
    
    // MARK: - Sign Out -
    func signOut(completion: @escaping(Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let error {
            self.log.error("Sign out error?", error.localizedDescription)
            completion(false)
        }
    }
}
