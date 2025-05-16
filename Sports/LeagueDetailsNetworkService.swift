//
//  LeagueDetailsNetworkService.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//



import Alamofire
import Foundation

protocol LeagueDetailsNetWorkServiceProtocol{
    
    static func fetchUpcomingEvents(sportName:String, leagueKey: Int, completion: @escaping ([Event]?) -> Void)
    static func fetchLatestEvents(sportName :String, leagueKey: Int, completion: @escaping ([Event]?) -> Void)
    static func fetchTeams(sportName :String, leagueKey: Int, completion: @escaping ([Team]?) -> Void)
    
}

class LeagueDetailsNetworkService: LeagueDetailsNetWorkServiceProtocol{

        static func fetchUpcomingEvents(sportName :String, leagueKey: Int, completion: @escaping ([Event]?) -> Void) {
            
            let endpoint = "/\(sportName.lowercased())/?met=Fixtures"
            let apiKey = "040e448bc7a1f6dabd9b1dd45e7d9d7f92e76f6af150254713bf49f781acb60e"
            let url = "https://apiv2.allsportsapi.com"+endpoint+"&leagueId=\(leagueKey)&from=\(getCurrentDate())&to=\(getFutureDate())&APIkey=\(apiKey)"
           
            print("url \(url)")
            
            AF.request(url).responseDecodable(of: EventResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data.result)
                case .failure(let error):
                    print("Error upComing  events: \(error)")
                    completion(nil)
                }
            }
        }
     
    
    static func fetchLatestEvents(sportName :String ,leagueKey: Int, completion: @escaping ([Event]?) -> Void) {
        let endpoint = "/\(sportName.lowercased())/?met=Fixtures"
        let apiKey = "040e448bc7a1f6dabd9b1dd45e7d9d7f92e76f6af150254713bf49f781acb60e"
        let url = "https://apiv2.allsportsapi.com" + endpoint + "&leagueId=\(leagueKey)&from=\(getPastDate())&to=\(getCurrentDate())&APIkey=\(apiKey)"
        
        AF.request(url).responseDecodable(of: EventResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.result)
            case .failure(let error):
                print("Error fetching latest events: \(error)")
                completion(nil)
            }
        }
    }

    static func fetchTeams(sportName :String, leagueKey: Int, completion: @escaping ([Team]?) -> Void) {
        let endpoint = "/\(sportName.lowercased())/?met=Teams"
        let apiKey = "040e448bc7a1f6dabd9b1dd45e7d9d7f92e76f6af150254713bf49f781acb60e"
        let url = "https://apiv2.allsportsapi.com" + endpoint + "&leagueId=\(leagueKey)&APIkey=\(apiKey)"
        
        AF.request(url).responseDecodable(of: TeamResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.result)
            case .failure(let error):
                print("Error fetching teams: \(error)")
                completion(nil)
            }
        }
    }

    
    private static func getPastDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let pastDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        return formatter.string(from: pastDate)
    }
    
    private static func getCurrentDate() -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          return formatter.string(from: Date())
      }
      
      private static func getFutureDate() -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          let futureDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())!
          return formatter.string(from: futureDate)
      }
}
