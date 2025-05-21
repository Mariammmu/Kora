//
//  TeamDetailsNetworkService.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import Foundation

import Foundation
import Alamofire

protocol TeamDetailsNetworkServiceProtocol {
    static func fetchTeamDetails(sportName :String,teamKey: Int, completion: @escaping (TeamDetails?) -> Void)
}

class TeamDetailsNetworkService: TeamDetailsNetworkServiceProtocol {
    static func fetchTeamDetails(sportName :String,teamKey: Int, completion: @escaping (TeamDetails?) -> Void) {
        
        let endpoint = "/\(sportName.lowercased())/?met=Teams&teamId="
        let apiKey = "040e448bc7a1f6dabd9b1dd45e7d9d7f92e76f6af150254713bf49f781acb60e"
        let url = "https://apiv2.allsportsapi.com/"+endpoint+"\(teamKey)&APIkey=\(apiKey)"
        
        AF.request(url).responseDecodable(of: TeamDetailsResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.result?.first)
            case .failure(let error):
                print("Error fetching team details: \(error)")
                completion(nil)
            }
        }
    }
}
