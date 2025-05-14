//
//  NetworkService.swift
//  Sports
//
//  Created by Macos on 13/05/2025.
//

import Foundation
import Alamofire


protocol NetworkProtocol{
    static func fetchLeagues(for sport: String, completion: @escaping (LeagueResponse?) -> Void)
}
class NetworkService: NetworkProtocol {
    static func fetchLeagues(for sport: String, completion: @escaping (LeagueResponse?) -> Void) {
        var endpoint = ""
        switch sport.lowercased() {
        case "football": endpoint = "/football/?met=Leagues"
        case "tennis": endpoint = "/tennis/?met=Leagues"
        case "basketball": endpoint = "/basketball/?met=Leagues"
        case "cricket": endpoint = "/cricket/?met=Leagues"
        default:
            completion(nil)
            return
        }
        
        let apiKey = "040e448bc7a1f6dabd9b1dd45e7d9d7f92e76f6af150254713bf49f781acb60e"
        let url = "https://apiv2.allsportsapi.com" + endpoint + "&APIkey=\(apiKey)"

        AF.request(url).responseDecodable(of: LeagueResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Network error: \(error)")
                completion(nil)
            }
        }
    }
}
