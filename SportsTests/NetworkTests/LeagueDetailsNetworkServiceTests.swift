//
//  LeagueDetailsNetworkServiceTests.swift
//  SportsTests
//
//  Created by Macos on 21/05/2025.
//

import Foundation
import XCTest
@testable import Sports

final class LeagueDetailsNetworkServiceTests: XCTestCase {
    
    func testFetchUpcomingEvents_Success() {
        
        let expectation = self.expectation(description: "Upcoming Events Fetched")
        
        LeagueDetailsNetworkService.fetchUpcomingEvents(sportName: "Football", leagueKey: 207) { events in
            
            XCTAssertNotNil(events, "Events should not be nil for valid sport and leagueKey")
            
            XCTAssertGreaterThan(events?.count ?? 0, 0, "Events count should be greater than 0")
            
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testFetchLatestEvents_Success() {
        
        let expectation = self.expectation(description: "Latest Events Fetched")
        
        LeagueDetailsNetworkService.fetchLatestEvents(sportName: "Football", leagueKey: 207) { events in
            
            XCTAssertNotNil(events, "Events should not be nil for valid sport and leagueKey")
            
            XCTAssertGreaterThan(events?.count ?? 0, 0, "Events count should be greater than 0")
            
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testFetchTeams_Success() {
        
        let expectation = self.expectation(description: "Teams Fetched")
        
        LeagueDetailsNetworkService.fetchTeams(sportName: "Football", leagueKey: 207) { teams in
            
            XCTAssertNotNil(teams, "Teams should not be nil for valid sport and leagueKey")
            
            XCTAssertGreaterThan(teams?.count ?? 0, 0, "Teams count should be greater than 0")
            
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
