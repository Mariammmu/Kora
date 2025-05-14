//
//  NetworkService.swift
//  Sports
//
//  Created by Macos on 11/05/2025.
//

import Foundation



//protocol NetworkProtocol {
//    
//    static func fetchDataFromJSON(compliationHundler : @escaping (SportsResponse?) -> Void)
//    
//}
//
//class NetworkService:NetworkProtocol {
//    
//    static var result : SportsResponse?
//    
//    
//    static func fetchDataFromJSON(compliationHundler : @escaping (SportsResponse?) -> Void) {
//        
//        let allSportsURL = URL(string: "https://www.thesportsdb.com/api/v1/json/3/all_sports.php")
//        
//        guard let newUrl = allSportsURL  else { return }
//        
//        
//        let request = URLRequest (url : newUrl)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            guard let data = data else { return}
//            
//            do {
//                
//                result = try JSONDecoder().decode(SportsResponse.self, from: data)
//                
//                compliationHundler(result)
//            
//                
//            }catch {
//                
//                print("Error parsing JSON: \(error)")
//                compliationHundler(nil)
//                
//            }
//            
//        }.resume()
//    }
//}
