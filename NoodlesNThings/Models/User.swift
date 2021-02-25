//
//  User.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import Foundation

struct NoodleUser: NoodlesCodable, Equatable {
    var id: String? = UUID().uuidString
    var email: String?
    /// - NOTE: Optional because it isn't stored in the Firebase User
    var username: String?
}
