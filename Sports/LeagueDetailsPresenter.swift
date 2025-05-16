//
//  LeagueDetailsPresenter.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import Foundation


protocol LeagueDetailsProtocol {
    func displayUpcomingEvents(events: [Event])
    func displayLatestEvents(events: [Event])
    func displayTeams(teams: [Team])
    func showError(message: String)
}

class LeagueDetailsPresenter {
     var view: LeagueDetailsProtocol?
    
    init(view: LeagueDetailsProtocol) {
        self.view = view
    }
    
    func fetchUpcomingEvents(sportName:String, leagueKey: Int) {
        
        LeagueDetailsNetworkService.fetchUpcomingEvents(sportName: sportName, leagueKey: leagueKey) { [weak self] events in
            DispatchQueue.main.async {
                if let events = events {
                    self?.view?.displayUpcomingEvents(events: events)
                } else {
                    self?.view?.showError(message: "Failed to fetch upcoming events.")
                }
            }
        }
    }
    
    func fetchLatestEvents(sportName: String, leagueKey: Int) {
        
        LeagueDetailsNetworkService.fetchLatestEvents(sportName: sportName, leagueKey: leagueKey) { [weak self] events in
            DispatchQueue.main.async {
                if let events = events {
                    self?.view?.displayLatestEvents(events: events)
                } else {
                    self?.view?.showError(message: "Failed to fetch latest events.")
                }
            }
        }
    }
    
    func fetchTeams(sportName: String, leagueKey: Int) {
        
        LeagueDetailsNetworkService.fetchTeams(sportName: sportName, leagueKey: leagueKey) { [weak self] teams in
            DispatchQueue.main.async {
                if let teams = teams {
                    self?.view?.displayTeams(teams: teams)
                } else {
                    self?.view?.showError(message: "Failed to fetch teams.")
                }
            }
        }
    }
}
