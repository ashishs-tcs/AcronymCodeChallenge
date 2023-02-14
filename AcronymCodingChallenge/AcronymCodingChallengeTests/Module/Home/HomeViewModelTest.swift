//
//  HomeViewModelTest.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 13/02/23.
//

import XCTest
@testable import AcronymCodingChallenge

final class HomeViewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// For success response
    func testAcronymData_Success() {
        // Arrange
        let mockNetworkService = MockNetworkService()
        let sut = HomeViewModel(networkService: mockNetworkService)
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "ViewModel test success")
        mockNetworkService.expectations = expectation
        
        // Act
        sut.getAcromine(sf: "APP")
        wait(for: [expectation], timeout: 10.0)
        
        // Assert
        XCTAssertTrue(mockNetworkService.getAcromineCalled)
        XCTAssertNotNil(sut.acromineModel)
        XCTAssertTrue(sut.acromineModel.count > 0)
    }
    
    /// For failure response
    func testAcronymData_Failure() {
        // Arrange
        let mockNetworkService = MockNetworkService()
        mockNetworkService.successResult = false
        let sut = HomeViewModel(networkService: mockNetworkService)
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "ViewModel test failure")
        mockNetworkService.expectations = expectation
        
        // Act
        sut.getAcromine(sf: "APP")
        wait(for: [expectation], timeout: 10.0)
        
        // Assert
        XCTAssertTrue(mockNetworkService.getAcromineCalled)
        XCTAssertTrue(sut.acromineModel.isEmpty)
    }
}
