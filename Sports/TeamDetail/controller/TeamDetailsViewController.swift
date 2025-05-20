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
    var teamName :String?
    var players: [Player] = []
    
    var presenter: TeamDetailsPresenter!
    
    var networkIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setActivityIndicator()
        
        if let teamName = teamName{
            
            navigationItem.title = "\(teamName) Team"
            
        }
        
        navigationController?.navigationBar.tintColor = UIColor(hex: "#C12A44")
        
        setUpCollectionView()
        
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
    
    
    func setActivityIndicator() {
        networkIndicator.center = view.center
        networkIndicator.color = .red
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
    
    // MARK: - TeamDetailsViewProtocol Methods
    func displayTeamDetails(teamDetails: TeamDetails) {
        
        DispatchQueue.main.async {
            
            self.teamNameLabel.text = teamDetails.teamName
            
            if let logoUrlString = teamDetails.teamLogo, let logoUrl = URL(string: logoUrlString) {
                
                self.teamImageView.kf.setImage(with: logoUrl, placeholder: UIImage(named: "team_logo"))
                
            }else {
                
                self.teamImageView.image = UIImage(named: "team_logo")
            }
            
            self.players = teamDetails.players ?? []
            
            self.playersCollectionView.reloadData()
            
            self.networkIndicator.stopAnimating()
            
        }
        
    }
    
    
    func drawPlayersSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
          
          group.interItemSpacing = .fixed(16)
          let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16)
          
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { index, environment in
        
            return self.drawPlayersSection()
           
        }
        playersCollectionView.setCollectionViewLayout(layout, animated: true)
        
        playersCollectionView.delegate = self
        playersCollectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func showError(message: String) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
        
    }
    
    // MARK: - UICollectionView DataSource Methods
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return max(players.count, 1)
        
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if players.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! PlayersNoDataCollectionViewCell
            
            cell.niDataImage.image = UIImage(named: "no_data")

            cell.noDataLabel.text = "No Players Found"
            return cell
        }

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playersCell", for: indexPath) as! PlayersCollectionViewCell
        
        let player = players[indexPath.item]
        
        cell.configure(with: player)
        
        return cell
        
    }
    
}
