//
//  CoreDataService.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import Foundation
import CoreData
import UIKit

class CoreDataService{
    
    var context:NSManagedObjectContext
    var entity: NSEntityDescription
    
    static let shared = CoreDataService()
    
    private init(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Sports", in: context)!
    }
    
    func addLeague(id: Int,name: String, logo:String?){
       let favLeague = NSManagedObject(entity: entity, insertInto: context)
        favLeague.setValue(id, forKey: "leagueId")
        favLeague.setValue(name, forKey: "leagueName")
        if let logo = logo, !logo.isEmpty{
            favLeague.setValue(logo, forKey: "leagueLogo")
        } else {
            if let placeHolder = UIImage(named: "league")?.pngData()?.base64EncodedString(){
                favLeague.setValue(placeHolder, forKey: "league")
            } else{
                favLeague.setValue("placeHolder", forKey: "league")
            }
        }
        
        do{
            try context.save()
            print("League added successfuly")
        } catch {
            print("Failed to add the league: \(error.localizedDescription)")
        }
    }
    
    func getAllLeagues() -> [Sports] {
        let fetchRequest: NSFetchRequest<Sports> = Sports.fetchRequest()
        
        
        
        do {
            let leagues = try context.fetch(fetchRequest)
            return leagues
        } catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteLeague( league: Sports){
        context.delete(league)
        try? context.save()
    }
    
    func getLeague(byId id: Int) -> Sports? {
        let fetchRequest: NSFetchRequest<Sports> = Sports.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", id)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch league by ID: \(error.localizedDescription)")
            return nil
        }
    }

    func isLeagueFavorite(id: Int) -> Bool {
        return getLeague(byId: id) != nil
    }
    
//    func deleteLeague(byId id: Int) {
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Sports")
//        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", id)
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            for league in results {
//                context.delete(league)
//            }
//            try context.save()
//            print("League(s) deleted successfully")
//        } catch {
//            print("Failed to delete league: \(error.localizedDescription)")
//        }
//    }
}
