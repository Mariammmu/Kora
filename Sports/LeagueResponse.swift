//
//  LeagueResponse.swift
//  Sports
//
//  Created by Macos on 12/05/2025.
//

import Foundation
//api key
//040e448bc7a1f6dabd9b1dd45e7d9d7f92e76f6af150254713bf49f781acb60e
//https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=040e448bc7a1f6dabd9b1dd45e7d9d7f92e76f6af150254713bf49f781acb60e
struct LeagueResponse: Codable {
    let success: Int
    let result: [League]
}

struct League: Codable {
    let leagueKey: Int //football, basketball, cricket, tennis
    let leagueName: String  //football, basketball, cricket, tennis
    let leagueYear: String? //cricket
    let leagueSurface: String? //tennis
    let countryKey: Int?  //football, basketball, tennis
    let countryName: String? //football, basketball, tennis
    let leagueLogo: String? //football
    let countryLogo: String? //football

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
        case leagueSurface = "league_surface"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"

    }
}
