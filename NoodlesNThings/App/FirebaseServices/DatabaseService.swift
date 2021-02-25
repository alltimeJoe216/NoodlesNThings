//
//  DatabaseService.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import Firebase

//MARK: - Completion Handlers -
typealias ResultWithUser = (Result<NoodleUser, Error>) -> Void

// MARK: - Error Handling -
fileprivate let file: String = #file
fileprivate let function: String = #function

enum DatabaseErrorHandler: NoodlesErrorProtocol {
    case nilId(domain: String, code: Int = 999, description: String = "The User ID was nil")
    
    var nsError: NSError {
        switch self {
        case .nilId(domain: let domain, code: let code, description: let description):
            return NSError(domain: domain, code: code, userInfo: ["localizedDescription": description])
        }
    }
}

/// used to avoid using string values in methods requiring a database reference
enum DatabasePaths: String {
    case users
}

class DatabaseService {
    let log = OSLog(DatabaseService.self, category: "ModelController_Firebase_Database")
    let db = Database.database()
    
    func createUser(user: NoodleUser, completion: @escaping ResultWithUser) {
        let function: String = #function
        
        guard let id = user.id else {
            let error = DatabaseErrorHandler.nilId(domain: "\(file).\(function)").nsError
            completion(.failure(error))
            log.error("%@.%@, %@", file, function, error.localizedDescription)
            return
        }
        let ref = db.reference(withPath: "\(DatabasePaths.users.rawValue)/\(id)")
        ref.setObject(user) { (error, ref) in
            if let error = error {
                completion(.failure(error))
                self.log.error("%@.%@, error setting data in firebase: %@", file, function, error.localizedDescription)
            } else {
                let dateFormatter = DateFormatter()
                let date = Date()
                dateFormatter.timeStyle = .short
                dateFormatter.dateStyle = .short
                
                let dateString = dateFormatter.string(from: date)
                self.log.info("New user created with id (%@) on %@", id, dateString)
                completion(.success(user))
            }
        }
    }
}
