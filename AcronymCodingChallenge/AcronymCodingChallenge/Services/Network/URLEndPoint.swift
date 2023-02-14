//
//  URLEndPoint.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import Foundation

/// The cloud infra, environment has been decided here.
/// The `String` cases are the deciding authority.
enum Environment: String {
    
    /// Development Server.
    case dev = "http://www.nactem.ac.uk/"
    
    /// The base url of the server.
    /// - Parameter env: `Environment` types of server.
    /// - Returns: `String` represents the chosed environment.
    static func base(_ env: Environment) -> String {
        return env.rawValue
    }
}

/// URL End Point
/// It will be used to handle API paths
struct URLEndPoint {
    
    /// Acromine API path
    static let ACROMINE = Environment.base(.dev) + "software/acromine/dictionary.py"
}
