//
//  MockNetworkService.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 11/02/23.
//

import XCTest
@testable import AcronymCodingChallenge

class MockNetworkService: NetworkServiceProtocol {
    var getAcromineCalled = false
    var successResult = true
    var expectations: XCTestExpectation?
    
    /// Test mock network service result with custom success and failure responses.
    func getAcromine(param: Encodable) async -> Result<[AcronymCodingChallenge.AcromineModel]?, AcronymCodingChallenge.ServerError> {
        getAcromineCalled = true
        expectations?.fulfill()
        
        if successResult {
            return .success([AcromineModel(sf: "APP", lfs: nil)])
        }
        
        return .failure(ServerError.networkRespose)
    }
}
