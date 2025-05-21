//
//  FakeLeagueDetailsNetwork.swift
//  SportsTests
//
//  Created by Macos on 20/05/2025.
//

import Foundation
@testable import Sports

protocol LeagueDetailsNetWorkServiceProtocol {
    func fetchUpcomingEvents(sportName: String, leagueKey: Int, completion: @escaping ([Event]?) -> Void)
    func fetchLatestEvents(sportName: String, leagueKey: Int, completion: @escaping ([Event]?) -> Void)
    func fetchTeams(sportName: String, leagueKey: Int, completion: @escaping ([Team]?) -> Void)
}

class FakeLeagueDetailsNetwork: LeagueDetailsNetWorkServiceProtocol{
   
    var shouldReturnError: Bool
      
      init(shouldReturnError: Bool) {
          self.shouldReturnError = shouldReturnError
      }
      
      private func loadMockEvents() -> [Event]? {

          let eventJsonResponse = """
          {
              "success": 1,
              "result": [
                  {
                      "event_key": 1001,
                      "event_date": "2025-06-01",
                      "event_time": "20:00",
                      "event_home_team": "Team A",
                      "event_away_team": "Team B",
                      "home_team_key": 1,
                      "away_team_key": 2,
                      "home_team_logo": null,
                      "away_team_logo": null,
                      "event_final_result": "2 - 1",
                      "event_status": "Finished",
                      "league_key": 10,
                      "league_name": "Mock League",
                      "league_round": "Final",
                      "event_stadium": "Mock Stadium"
                  }
              ]
          }
          """
          
          guard let data = eventJsonResponse.data(using: .utf8) else {
              print("Failed to convert mock JSON string to Data.")
              return nil
          }
          
          do {
              let decoded = try JSONDecoder().decode(EventResponse.self, from: data)
              return decoded.result
          } catch {
              print("Error decoding mock JSON: \(error)")
              return nil
          }
      }
      
      func fetchUpcomingEvents(sportName: String, leagueKey: Int, completion: @escaping ([Event]?) -> Void) {
          if shouldReturnError {
              completion(nil)
          } else {
              completion(loadMockEvents())
          }
      }
      
      func fetchLatestEvents(sportName: String, leagueKey: Int, completion: @escaping ([Event]?) -> Void) {
          if shouldReturnError {
              completion(nil)
          } else {
              completion(loadMockEvents())
          }
      }
      
      func fetchTeams(sportName: String, leagueKey: Int, completion: @escaping ([Team]?) -> Void) {
          if shouldReturnError {
              completion(nil)
          } else {
              let mockTeam = Team(teamKey: 1, teamName: "Team A", teamLogo: nil)
              completion([mockTeam])
          }
      }
  }
