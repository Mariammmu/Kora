//
//  AllSportsResponse.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import Foundation


struct SportsResponse: Codable {
    let sports: [Sport]
}

struct Sport: Codable {
    let strSport: String
    let strSportThumb: String
}
