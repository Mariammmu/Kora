//
//  TeamDetailsResponse.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import Foundation

struct TeamDetailsResponse: Codable {
    let success: Int
    let result: [TeamDetails]?
}

struct TeamDetails: Codable {
    let teamName: String
    let teamLogo: String?
    let players: [Player]?

    enum CodingKeys: String, CodingKey {
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players = "players"
    }
}
