//
//  PlayersResponse.swift
//  Sports
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct PlayersResponse: Codable {
    let success: Int
    let result: [Player]?
}

struct Player: Codable {
    let playerName: String?
    let playerNumber: String?
    let playerAge: String?
    let playerImage: String?
    
    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerAge = "player_age"
        case playerImage = "player_image"
    }
}
