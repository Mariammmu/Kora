//
//  FavTableViewController.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import UIKit
import Reachability
import CoreData
import Alamofire

class FavTableViewController: UITableViewController {

  
    var favoriteLeagues: [NSManagedObject] = [] //to receive the added leagues from leaguesDetails
        var presenter: FavLeaguePresenter!
        var reachability: Reachability?


    override func viewDidLoad() {
        super.viewDidLoad()
        
                setupReachability()

                
                presenter = FavLeaguePresenter()
                presenter.attachView(view: self)
                
              
                presenter.fetchFavouriteLeagues()
        
                navigationItem.title = "Favorite Leagues"
        
        
    }
    
    func setupReachability() {
            reachability = try? Reachability()
            
            
        reachability?.whenReachable = { [weak self] reachability in
                
                self?.presenter.fetchFavouriteLeagues()
            }
            
            reachability?.whenUnreachable = { [weak self] _ in
              
                self?.showError(message: "No internet connection")
            }
            
            do {
                try reachability?.startNotifier()
            } catch {
                print("Unable to start Reachability notifier")
            }
        }
        
        deinit {
            reachability?.stopNotifier()
        }
 
    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFavouriteLeagues()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        favoriteLeagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favLeagueCell", for: indexPath)  as! FavLeagueTableViewCell
        
        let league = favoriteLeagues[indexPath.row]
            
            if let name = league.value(forKey: "leagueName") as? String {
                cell.favLeagueName.text = name
            }

            if let logoString = league.value(forKey: "leagueLogo") as? String,
               let url = URL(string: logoString) {
                
               
                AF.request(url).responseData { response in
                    switch response.result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            cell.favLeagueImage.image = UIImage(data: data)
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            cell.favLeagueImage.image = UIImage(named: "league")
                        }
                    }
                }
            } else {
                cell.favLeagueImage.image = UIImage(named: "league")
            }

            return cell
        }
    func displayFavouriteLeagues(_ leagues: [NSManagedObject]) {
        self.favoriteLeagues = leagues
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }

            let alert = UIAlertController(
                title: "Delete Favorite",
                message: "Are you sure you want to delete this league from favorites?",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                completionHandler(false)
            }))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.presenter.deleteLeague(at: indexPath.row, from: self.favoriteLeagues)
                completionHandler(true)
            }))

            self.present(alert, animated: true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard reachability?.connection != .unavailable else {
              showError(message: "No internet connection")
              return
          }

          guard let selectedLeague = favoriteLeagues[indexPath.row] as? Sports else { return }

         // let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController {
              
              detailsVC.leagueKey = Int(selectedLeague.leagueId)
              detailsVC.leagueName = selectedLeague.leagueName
              detailsVC.leagueLogo = selectedLeague.leagueLogo
              detailsVC.sportName = "football"

              navigationController?.pushViewController(detailsVC, animated: true)
          }
      }
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func showError(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
