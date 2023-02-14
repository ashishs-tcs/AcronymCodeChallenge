//
//  NetworkServiceTest.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 14/02/23.
//

import XCTest
@testable import AcronymCodingChallenge

final class NetworkServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Test actual API call with actual response from cloud server.
    func testAcronymAPICall_Success() {
        // Arrange
        let sut = NetworkService()
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "Call API asynchronously.")
        
        // Act
        let param = RequestModel.AcromineInfo(sf: "App", lf: "")
        Task {
            let result = await sut.getAcromine(param: param)
            switch result {
            case .success(let model):
                if let model {
                    // Assert
                    XCTAssertNotNil(model)
                    XCTAssertTrue(model.count > 0)
                    
                    // Fulfill the expectation.
                    expectation.fulfill()
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        // Wait for the expectation to fulfill or time out.
        wait(for: [expectation], timeout: 10.0)
    }

    func testAcronymAPICall_Failure() {
        // Arrange
        let sut = NetworkService()
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "Call API asynchronously.")
        
        // Act
        let param = RequestModel.AcromineInfo(sf: "A", lf: "")
        Task {
            let result = await sut.getAcromine(param: param)
            switch result {
            case .success(let model):
                if let model {
                    // Assert
                    XCTAssertNotNil(model)
                    XCTAssertFalse(model.count > 0)
                    
                    // Fulfill the expectation.
                    expectation.fulfill()
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        // Wait for the expectation to fulfill or time out.
        wait(for: [expectation], timeout: 10.0)
    }
}