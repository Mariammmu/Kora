//
//  LeaguePresenter.swift
//  Sports
//
//  Created by Macos on 13/05/2025.
//

import Foundation


protocol LeaguesProtocol{
    
    func displayLeagues( leagues: [League])
    
    func showError (message: String)
}

class LeaguesPresenter{
    //weak
     var view: LeaguesProtocol?
    
    init(view: LeaguesProtocol) { //question
        self.view = view
    }

    func getDataFromModel(sport: String) {
        NetworkService.fetchLeagues(for: sport) { [weak self] result in
            DispatchQueue.main.async {
                if let result = result {
                    self?.view?.displayLeagues(leagues: result.result)
                } else {
                    self?.view?.showError(message: "Failed to fetch products")
                }
            }
        }
    }
}

