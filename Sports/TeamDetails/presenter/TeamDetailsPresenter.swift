//
//  TeamDetailsPresenter.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import Foundation


class TeamDetailsPresenter {
    
    weak var view: TeamDetailsViewController?
 
    
    func attachView(view: TeamDetailsViewController) {
        
        self.view = view
   
    }
    
    func fetchTeamDetails(sportName :String, teamKey: Int) {
        
        TeamDetailsNetworkService.fetchTeamDetails(sportName :sportName, teamKey: teamKey) { [weak self] teamDetails in
           
                if let teamDetails = teamDetails {
                    
                    self?.view?.displayTeamDetails(teamDetails: teamDetails)
                    
                } 
            else {
                    
                    self?.view?.showError(message: "No Data Found.")
           
                }
            
            
        }
    }
}
