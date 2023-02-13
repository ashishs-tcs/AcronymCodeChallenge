//
//  NetworkService+Validation.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import Foundation

extension URLResponse {
    
    typealias Error = NetworkService.ResponseError
    
    var errorAppeared: Error? {
        if let httpsResponse = self as? HTTPURLResponse {
            let statusCode = httpsResponse.statusCode
            switch statusCode {
            case 200...299: return nil
            case 300...399: return Error.requestValidation
            case 400...499: return Error.requestNotFound
            case 500...599: return Error.internalServer
            default: return Error.unexpected(statusCode)
            }
        }
        return Error.wrapperFailed
    }
}
