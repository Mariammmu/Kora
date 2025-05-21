//
//  LeagueTableViewController.swift
//  Sports
//
//  Created by Macos on 12/05/2025.
//

import UIKit
import Alamofire
class LeagueTableViewController: UITableViewController{
  
    var presenter: LeaguesPresenter?
        var leagues: [League] = []

    var selectedSport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sportName = selectedSport {
            
            navigationItem.title = "\(sportName) Leagues"
            
        }
        
        navigationController?.navigationBar.tintColor = UIColor(hex: "#C12A44")
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if let sport = selectedSport {
            
            presenter = LeaguesPresenter()
            
            presenter?.attachView(view: self)
            
            presenter?.getDataFromModel(sport: sport)
            
        } else {
        
            showError(message: "No sport selected.")
            
        }
        
        if let borderColor = UIColor(named: "BorderColor") {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = borderColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // or your desired text color
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.tintColor = .white
            
        }
    }

    func displayLeagues(leagues: [League]) {
        
        self.leagues = leagues
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            
        }
               
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return max(leagues.count ,1 )
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if leagues.isEmpty {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! LeagueNoDataTableViewCell
          
            cell.noDataImage.image = UIImage(named: "no_data")

            cell.noDataLabel.text = "No Internet Connection"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell

        let league = leagues[indexPath.row]
           cell.leagueName.text = league.leagueName
           cell.leagueImage.image = UIImage(named: "league")
           cell.startShimmering()

           if let logoURL = league.leagueLogo, let url = URL(string: logoURL) {
               AF.request(url).responseData { response in
                   DispatchQueue.main.async {
                       cell.stopShimmering()
                       switch response.result {
                       case .success(let data):
                           cell.leagueImage.image = UIImage(data: data)
                       case .failure(_):
                           cell.leagueImage.image = UIImage(named: "league")
                       }
                   }
               }
           } else {
               cell.stopShimmering()
               cell.leagueImage.image = UIImage(named: "league")
           }

           return cell
       }
    
    
    
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        let selectedLeague = leagues[indexPath.row]
        leagueDetailsVC.leagueKey = selectedLeague.leagueKey
        leagueDetailsVC.sportName = selectedSport
        leagueDetailsVC.leagueName = selectedLeague.leagueName
        leagueDetailsVC.leagueLogo = selectedLeague.leagueLogo
        
        leagueDetailsVC.screenMode = "league"
        
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
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
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let spacerView = UIView()
//        spacerView.backgroundColor = .clear
//        return spacerView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 12
//    }


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
