//
//  Event.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import Foundation

struct EventResponse: Codable {
    let success: Int
    let result: [Event]?
}

struct Event: Codable {
    let eventKey: Int?              
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamKey: Int?
    let awayTeamKey: Int?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let leagueKey: Int?
    let leagueName: String?
    let leagueRound: String?
    let eventStadium: String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case homeTeamKey = "home_team_key"
        case awayTeamKey = "away_team_key"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueRound = "league_round"
        case eventStadium = "event_stadium"
    }
}
