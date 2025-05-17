//
//  LeagueDetailsPresenter.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import Foundation


class LeagueDetailsPresenter {
    
    var view: LeagueDetailsViewController?
    
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
}
