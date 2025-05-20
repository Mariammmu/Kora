//
//  MockLeagueDetails.swift
//  SportsTests
//
//  Created by Macos on 20/05/2025.
//

import XCTest
@testable import Sports
final class MockLeagueDetails: XCTestCase {

    var fakeService: FakeLeagueDetailsNetwork?

    
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
    
       func testFetchUpcomingEvents_Success() {
        fakeService = FakeLeagueDetailsNetwork(shouldReturnError: false)
        let expectation = expectation(description: "Upcoming Events")
        
        fakeService?.fetchUpcomingEvents(sportName: "football", leagueKey: 1) { events in
            XCTAssertNotNil(events)
            XCTAssertEqual(events?.first?.eventHomeTeam, "Team A")
            XCTAssertEqual(events?.first?.leagueName, "Mock League")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
     
        func testFetchUpcomingEvents_Failure() {
            fakeService = FakeLeagueDetailsNetwork(shouldReturnError: true)
            let expectation = expectation(description: "Upcoming Events Failure")
     
            fakeService?.fetchUpcomingEvents(sportName: "football", leagueKey: 1) { events in
                XCTAssertNil(events)
                expectation.fulfill()
            }
     
            waitForExpectations(timeout: 1)
        }
    
    func testFetchLatestEvents_Success() {
          fakeService = FakeLeagueDetailsNetwork(shouldReturnError: false)
          let expectation = expectation(description: "Latest Events")
   
          fakeService?.fetchLatestEvents(sportName: "football", leagueKey: 1) { events in
              XCTAssertNotNil(events)
              XCTAssertEqual(events?.first?.eventAwayTeam, "Team B")
              expectation.fulfill()
          }
   
          waitForExpectations(timeout: 1)
      }
   
      func testFetchLatestEvents_Failure() {
          fakeService = FakeLeagueDetailsNetwork(shouldReturnError: true)
          let expectation = expectation(description: "Latest Events Failure")
   
          fakeService?.fetchLatestEvents(sportName: "football", leagueKey: 1) { events in
              XCTAssertNil(events)
              expectation.fulfill()
          }
   
          waitForExpectations(timeout: 1)
      }
   

}
