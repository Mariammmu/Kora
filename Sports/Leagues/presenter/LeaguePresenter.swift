//
//  LeaguePresenter.swift
//  Sports
//
//  Created by Macos on 13/05/2025.
//

import Foundation



class LeaguesPresenter{
    //weak
     var view: LeagueTableViewController?
    
    func attachView(view: LeagueTableViewController) { //question
    
        self.view = view
   
    }

    func getDataFromModel(sport: String) {
        
        NetworkService.fetchLeagues(for: sport) { [weak self] result in
       
            if let result = result {
                
                self?.view?.displayLeagues(leagues: result.result)
                
            } else {
                
                self?.view?.showError(message: "Failed to fetch Leagues")
                
            }
            
        }
    }
}

