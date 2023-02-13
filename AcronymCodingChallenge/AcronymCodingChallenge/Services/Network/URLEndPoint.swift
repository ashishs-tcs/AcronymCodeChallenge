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
    
    /// QA Server.
    case qa = "https://1.2.3.4/"
    
    // Stage Server.
    case stage = "https://5.6.7.8/"
    
    /// The base url of the server.
    /// - Parameter env: `Environment` types of server.
    /// - Returns: `String` represents the chosed environment.
    static func base(_ env: Environment) -> String {
        return env.rawValue
    }
}


struct URLEndPoint {
    
    /// Path for cloud environment.
    private static let path = "software/"
    
    /// Currently via code only we can change this server environment.
    /// Note: - We have a backlog, that to setup a schema for this.
    /// Based on schema, the server path will change.
    private static let BASE = Environment.base(.dev) + URLEndPoint.path
    
    static let ACROMINE = URLEndPoint.BASE + "acromine/dictionary.py"/// + path or API if any
}
