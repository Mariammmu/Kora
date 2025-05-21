//
//  FavLeaguePresenter.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import Foundation
import CoreData

protocol FavLeaguesViewProtocol: AnyObject {
    func displayFavouriteLeagues(_ leagues: [NSManagedObject])
}

class FavLeaguePresenter{
   // var viewController : FavTableViewController!
    //weak
    var view: FavLeaguesViewProtocol!

    func setViewController (viewProtocol : FavLeaguesViewProtocol){
        //self.viewController = viewController
    
        self.view = viewProtocol
    }
    
    func getAllFavourite(){
        
        let favoriteLeagues = CoreDataService.shared.getAllLeagues()
        view?.displayFavouriteLeagues(favoriteLeagues)
    }
    
    
}
