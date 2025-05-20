//
//  Team.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import Foundation

struct TeamResponse:Codable {
    
    let success: Int
    let result: [Team]
}

struct Team: Codable {
    let teamKey: Int?
    let teamName: String
    let teamLogo: String?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}
