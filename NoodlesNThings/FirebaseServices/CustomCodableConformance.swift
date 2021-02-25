//
//  CustomCodableConformance.swift
//  NoodlesNThings
//
//  Created by Joseph Veverka on 2/25/21.
//

import UIKit
import Firebase

extension DatabaseReference {
    /// POST a Swift object to Firebase using the firebase SDK
    func setObject(_ object: NoodlesCodable, withCompletionBlock: @escaping (Error?, DatabaseReference?) -> Void) {
        self.setValue(object.toDictionary(), withCompletionBlock: withCompletionBlock)
    }
    
}

/// Adopt Firebase Codable Conformance
protocol NoodlesCodable: Codable {
    func toDictionary() -> [String : Any]
}

extension NoodlesCodable {
    func toDictionary() -> [String : Any] {
        let jsonEncoder = JSONEncoder()
        // serialize the data or return an empty dictionary on failure
        return (try? JSONSerialization.jsonObject(with: jsonEncoder.encode(self))) as? [String: Any] ?? [:]
    }
}

// MARK: - Snapshot toObject Implementation -
extension JSONDecoder {
    /// Decode the document as the specified type (T)
    /// - Returns: on success, an optional instance of the type
    /// that's passed in. On failure, a decode error
    // TODO: Test
    func decode<T>(_ type: T.Type, from value: Any) throws -> T where T : Decodable {
        do {
            let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
            let decoded = try decode(type, from: data)
            return decoded

        } catch {
            throw error
        }
    }
}
