//
//  AllSportResponse.swift
//  Sports
//
//  Created by Macos on 11/05/2025.
//


import Foundation

struct SportsResponse: Codable {
    let sports: [Sport]
}

struct Sport: Codable {
    let strSport: String
    let strSportThumb: String
}

