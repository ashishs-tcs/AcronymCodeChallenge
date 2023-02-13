//
//  NetworkService+Error.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import Foundation

typealias ServerError = NetworkService.ResponseError

extension NetworkService {
    
    /// The network response related error has been declared here.
    enum ResponseError: Error {
        case noInternet
        case networkRespose
        case requestNotFound
        case requestValidation
        case internalServer
        case unexpected(Int)
        case wrapperFailed
        case tryCatch(Error)
        case emptyData
        case none
        
        
        /// `String` represents the error in detail.
        var message: String {
            switch self {
            case .noInternet:
                return "Internet appears to be offline. Try again after some times"
            case .networkRespose:
                return "Cloud server is not responding. Try again after some times"
            case .requestNotFound:
                return "Request not found"
            case .requestValidation:
                return "Internal request failed, check the request once again."
            case .internalServer:
                return "Internal server error." // Check with your API team.
            case .unexpected(let code):
                return "unexpected error occured, Error Code - \(code)"
            case .wrapperFailed:
                return "Optional unwrapping failed. Check the response model"
            case .tryCatch(let error):
                return "Error Occurred in Try-Catch block - \(error.localizedDescription)"
            case .emptyData:
                return "Not found any data."
            case .none:
                return "No error"
            }
        }
    }
}
