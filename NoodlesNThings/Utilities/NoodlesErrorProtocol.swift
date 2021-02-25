//
//  NoodlesErrorProtocol.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import Foundation
/// - Note: Use cases with associated IDs to create errors.
/// - Usage Example:
/// ```
/// enum ErrorHandler: FameErrorProtocol {
///     case unknown(domain: String, description: String = "An unknown Error Occurred.")
///
///     var nsError: NSError {
///         switch self {
///         case .unknown(let domain, let description):
///             return NSError(domain: domain, code: 999, userInfo: ["localizedDescription": description])
///         }
///     }
///}
/// ```
protocol NoodlesErrorProtocol {
    var nsError: NSError { get }
}
