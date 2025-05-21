//
//  FavLeaguePresenter.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import Foundation
import CoreData

class FavLeaguePresenter {
    weak var view: FavTableViewController?

    func attachView(view: FavTableViewController) {
        self.view = view
    }

    func fetchFavouriteLeagues() {
        let favoriteLeagues = CoreDataService.shared.getAllLeagues()
        view?.displayFavouriteLeagues(favoriteLeagues)
    }

    func deleteLeague(at index: Int, from leagues: [NSManagedObject]) {
        guard let leagueToDelete = leagues[index] as? Sports else { return }
        CoreDataService.shared.deleteLeague(league: leagueToDelete)
        fetchFavouriteLeagues()
    }
}
