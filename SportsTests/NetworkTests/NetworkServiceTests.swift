//
//  NetworkServiceTests.swift
//  SportsTests
//
//  Created by Macos on 20/05/2025.
//

import XCTest
@testable import Sports
final class NetworkServiceTests: XCTestCase {


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchLeagues_Success() {
        let expectation = self.expectation(description: "Leagues Fetched")
 
        NetworkService.fetchLeagues(for: "Football") { response in
  
            XCTAssertNotNil(response, "Response should not be nil for valid sport")
            XCTAssertNotNil(response?.result, "Result should contain leagues")
            expectation.fulfill()
        }
 
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testFetchLeagues_InvalidSport_ReturnsNil() {
           let expectation = self.expectation(description: "Invalid Sport")
    
           NetworkService.fetchLeagues(for: "InvalidSportName") { response in
               XCTAssertNil(response, "Response should be nil for invalid sport")
               expectation.fulfill()
           }
    
           waitForExpectations(timeout: 5, handler: nil)
       }

}
