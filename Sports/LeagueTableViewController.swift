//
//  LeagueTableViewController.swift
//  Sports
//
//  Created by Macos on 12/05/2025.
//

import UIKit

class LeagueTableViewController: UITableViewController, LeaguesProtocol {
  
    var presenter: LeaguesPresenter?
        var leagues: [League] = []

    var selectedSport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if let sport = selectedSport {
                    presenter = LeaguesPresenter(view: self)
                    presenter?.getDataFromModel(sport: sport)
                } else {
                    showError(message: "No sport selected.")
                }
    }

    func displayLeagues(leagues: [League]) {
        self.leagues = leagues
                tableView.reloadData()
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
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell

        // Configure the cell...
   
        let league = leagues[indexPath.row]
        cell.leagueName.text = league.leagueName

        if let logoURL = league.leagueLogo, let url = URL(string: logoURL) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.leagueImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        } else {
            cell.leagueImage.image = UIImage(systemName: "sportscourt") // Placeholder
        }


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let leagueDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
       
        let selectedLeague = leagues[indexPath.row]
        
        leagueDetailsVC.leagueKey = selectedLeague.leagueKey
        leagueDetailsVC.sportName = selectedSport
        
        if let key = leagueDetailsVC.leagueKey {
                print("Selected League Key: \(key)")
            } else {
                print("League Key is nil")
            }
        
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
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
