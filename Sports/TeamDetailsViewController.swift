//
//  TeamDetailsViewController.swift
//  Sports
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    var myTeamKey: Int?
    var mysportName: String?
    var players: [Player] = []
    
    var presenter: TeamDetailsPresenter!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter = TeamDetailsPresenter()
        
        presenter.attachView(view: self)
        
        playersCollectionView.delegate = self
        
        playersCollectionView.dataSource = self
        
        if let key = myTeamKey, let sName = mysportName{
            
            presenter?.fetchTeamDetails(sportName: sName, teamKey: key)
            
        } else {
            
            showError(message: "Invalid Team Key")
            
        }
        
    }
    
    
    // MARK: - TeamDetailsViewProtocol Methods
    func displayTeamDetails(teamDetails: TeamDetails) {
        
        DispatchQueue.main.async {
            
            self.teamNameLabel.text = teamDetails.teamName
            
            if let logoUrlString = teamDetails.teamLogo, let logoUrl = URL(string: logoUrlString) {
                
                self.teamImageView.kf.setImage(with: logoUrl)
                
            }
            
            self.players = teamDetails.players ?? []
            
            self.playersCollectionView.reloadData()
            
        }
        
    }
    
    
    func showError(message: String) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
        
    }
    
    // MARK: - UICollectionView DataSource Methods
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return players.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playersCell", for: indexPath) as! PlayersCollectionViewCell
        
        let player = players[indexPath.item]
        
        cell.configure(with: player)
        
        return cell
        
    }
    
}
