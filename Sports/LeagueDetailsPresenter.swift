//
//  LeagueDetailsPresenter.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import Foundation

protocol LeagueDetailsProtocol: AnyObject {
    func setupFavoriteButton(isFavorite: Bool)
}

class LeagueDetailsPresenter {
    
    var view: LeagueDetailsViewController?
    
      // var leagueId: Int?

//    var leagueName: String?
//    var leagueLogo: String?
//
    func attachView(view: LeagueDetailsViewController) {
        
        self.view = view
        
    }
    
    func fetchUpcomingEvents(sportName:String, leagueKey: Int) {
        
        LeagueDetailsNetworkService.fetchUpcomingEvents(sportName: sportName, leagueKey: leagueKey){ [weak self] events in
            
            if let events = events {
                
                self?.view?.displayUpcomingEvents(events: events)
                
            } else {
                
                self?.view?.showError(message: "No Data Found.")
                
            }
        }
    }
    
    func fetchLatestEvents(sportName: String, leagueKey: Int) {
        
        LeagueDetailsNetworkService.fetchLatestEvents(sportName: sportName, leagueKey: leagueKey){ [weak self] events in
            
            if let events = events {
                
                self?.view?.displayLatestEvents(events: events)
                
            } else {
                
                self?.view?.showError(message: "No Data Found.")
                
            }
        }
    }
    
    func fetchTeams(sportName: String, leagueKey: Int) {
        
        LeagueDetailsNetworkService.fetchTeams(sportName: sportName, leagueKey: leagueKey){ [weak self] teams in
            
            if let teams = teams {
                
                self?.view?.displayTeams(teams: teams)
                
            } else {
                
                self?.view?.showError(message: "No Data Found.")
                
            }
        }
    }
//    func setLeagueDetails(id: Int, name: String, logo: String) {
//            self.leagueId = id
//            self.leagueName = name
//            self.leagueLogo = logo
//
//            // Update the button on load
//            view?.setupFavoriteButton(isFavorite: isLeagueFavorite())
//        }
//    
//    func isLeagueFavorite() -> Bool {
//        guard let id = leagueId else { return false }
//        return CoreDataService.shared.isLeagueFavorite(id: id)
//    }
//
//    func toggleFavorite() {
//        guard let id = leagueId,
//              let name = leagueName,
//              let logo = leagueLogo else { return }
//
//        if let league = CoreDataService.shared.getLeague(byId: id) {
//            CoreDataService.shared.deleteLeague(league: league)
//        } else {
//            CoreDataService.shared.addLeague(id: id, name: name, logo: logo)
//        }
//
//        view?.setupFavoriteButton(isFavorite: isLeagueFavorite())
//    }
    
}
