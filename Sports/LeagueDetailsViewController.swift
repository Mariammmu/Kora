//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import ShimmerSwift
class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    
    @IBOutlet weak var collectionView: UICollectionView!

    var isLoading = true
    var leagueKey: Int?
    var sportName: String?
    
    var isFavorite: Bool = false
    var leagueName: String?
    var leagueLogo: String?
    
    
    var presenter: LeagueDetailsPresenter?
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: [Team] = []
    
    var favButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter = LeagueDetailsPresenter()
        
        presenter?.attachView(view: self)
        
        setUpCollectionView()
        
        if let key = leagueKey, let sName = sportName, let name = leagueName {
            presenter?.fetchUpcomingEvents(sportName: sName, leagueKey: key)
            presenter?.fetchLatestEvents(sportName: sName, leagueKey: key)
            presenter?.fetchTeams(sportName: sName, leagueKey: key)
            
            presenter?.setLeagueDetails(id: key, name: name, logo: leagueLogo)
          
            

        } else {
            showError(message: "Invalid League Key or Sport Name")
        }
    

        setupFavoriteButton(isFavorite: false)
    }
    
    func setupFavoriteButton(isFavorite: Bool) {
         let buttonImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
         favButton = UIBarButtonItem(
             image: buttonImage,
             style: .plain,
             target: self,
             action: #selector(pressRightButton)
         )
         favButton?.tintColor = UIColor(named: "borderColor")
         navigationItem.rightBarButtonItem = favButton
     }
    
    
//    func setupFavoriteButton(isFavorite:Bool){
//        let favButton = UIBarButtonItem(
//            image: isFavorite == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"),
//            style: .plain,
//            target: self,
//            action: #selector (pressRightButton))
//        favButton.tintColor = UIColor(named: "borderColor")
//
//        navigationItem.rightBarButtonItem = favButton
//
//    }

    
    @objc func pressRightButton() {
        presenter?.toggleFavorite()
    }
    
    
    func drawUpcomingEventsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 16, trailing: 0)
        
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
    
    
    func drawLatestResultsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 16, trailing: 16)
        
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
    
    func drawTeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 16, trailing: 0)
        
        
        
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
            if index == 0 {
                return self.drawUpcomingEventsSection()
            } else if index == 1 {
                return self.drawLatestResultsSection()
            }else{
                return self.drawTeamsSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return teams.count
        case 1: return upcomingEvents.count
        case 2: return latestEvents.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingEventsCell", for: indexPath) as! UpComingEventsCollectionViewCell
            cell.configure(event: upcomingEvents[indexPath.item])
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventCollectionViewCell
            cell.configure(event: latestEvents[indexPath.item])
            return cell
            
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            let team = teams[indexPath.item]
            cell.config(teamTitle: team.teamName ?? "N/A", teamImg: team.teamLogo ?? "")
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let teamVC = storyboard?.instantiateViewController(withIdentifier: "teamDetailsViewController") as! TeamDetailsViewController
            
            let selectedTeam = teams[indexPath.item]
            
            teamVC.myTeamKey = selectedTeam.teamKey
            
            teamVC.mysportName = sportName
            
            
            if let key = teamVC.myTeamKey {
                print("Selected Team Key: \(key)")
                
            } else {
                
                print("Team Key is nil")
                
            }
            
            navigationController?.pushViewController(teamVC, animated: true)
            
        }
        
    }
    
    func displayUpcomingEvents(events: [Event]) {
        
        self.upcomingEvents = events
        
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    func displayLatestEvents(events: [Event]) {
        
        self.latestEvents = events
        
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    func displayTeams(teams: [Team]) {
        
        self.teams = teams
        
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    func showError(message: String) {
        print("Error: \(message)")
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
    
}
