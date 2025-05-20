//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    var leagueKey: Int?
    var sportName: String?
    
    var isFavorite: Bool = false
    var leagueName: String?
    var leagueLogo: String?
    
    
    var presenter: LeagueDetailsPresenter?
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: [Team] = []
    
    var networkIndicator = UIActivityIndicatorView(style: .large)
    
    var favButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        if let leagueName = leagueName {
            
            navigationItem.title = "\(leagueName.capitalized)"
            
        }
        
        navigationController?.navigationBar.tintColor = UIColor(hex: "#C12A44")
        
        setActivityIndicator()
        
        presenter = LeagueDetailsPresenter()
        
        presenter?.attachView(view: self)
        
        setUpCollectionView()
        
        if let key = leagueKey, let sName = sportName {
            presenter?.fetchUpcomingEvents(sportName: sName, leagueKey: key)
            presenter?.fetchLatestEvents(sportName: sName, leagueKey: key)
            presenter?.fetchTeams(sportName: sName, leagueKey: key)
            
            isFavorite = CoreDataService.shared.isLeagueFavorite(id: key)
                   setupFavoriteButton(isFavorite: isFavorite)

        }
//        else {
//            showError(message: "Invalid League Key or Sport Name")
//        }
    

        setupFavoriteButton(isFavorite: false)
    }
    
    func setActivityIndicator() {
        networkIndicator.center = view.center
        networkIndicator.color = .red
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
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
    
//    @objc func pressRightButton(){
//        presenter?.toggleFavorite()
//    }
    
    @objc func pressRightButton() {
         // guard let id = leagueKey, let name = leagueName, let logo = leagueLogo else {
          guard let id = leagueKey, let name = leagueName else {
              showError(message: "League data is missing")
              return
          }
       
          if isFavorite {
              if let league = CoreDataService.shared.getLeague(byId: id) {
                  CoreDataService.shared.deleteLeague(league: league)
              }
              isFavorite = false
          } else {
              CoreDataService.shared.addLeague(id: id, name: name, logo: leagueLogo)
              isFavorite = true
          }
       
          setupFavoriteButton(isFavorite: isFavorite)
      }
      

    
    func drawUpcomingEventsSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
//            group.interItemSpacing = .fixed(16)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
          let header = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerSize,
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top
          )
          section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    func drawLatestResultsSection() -> NSCollectionLayoutSection {
        
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
          let header = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerSize,
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top
          )
          section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
//           group.interItemSpacing = .fixed(16)
           let section = NSCollectionLayoutSection(group: group)
           section.orthogonalScrollingBehavior = .continuous
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
          let header = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerSize,
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top
          )
          section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "teamDetailsLabel", for: indexPath) as! TeamDetailsCollectionReusableView
            switch indexPath.section{
            case 0:
                header.labelName.text = "Up Coming Matches"
            case 1:
                header.labelName.text = "Past Matches"
            default:
                header.labelName.text = "Teams"
            }
            
            return header
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
        case 0: return max(upcomingEvents.count, 1)
        case 1: return max(latestEvents.count, 1)
        case 2: return max(teams.count, 1)
        default: return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            
            if upcomingEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCollectionViewCell
              
                cell.noDataimage.image = UIImage(named: "no_data")


                cell.noDatalabel.text = "No Upcoming Events"
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingEventsCell", for: indexPath) as! UpComingEventsCollectionViewCell
            cell.configure(event: upcomingEvents[indexPath.item])
            
            let backgroundImageView = UIImageView(frame: cell.bounds)
                  
            backgroundImageView.contentMode = .scaleAspectFill
            
            backgroundImageView.clipsToBounds = true
            
            backgroundImageView.layer.cornerRadius = 15
            
            
            if(sportName?.lowercased() == "football"){
                
                backgroundImageView.image = UIImage(named: "soccer_bg")
                
            }else if (sportName?.lowercased() == "tennis"){
                
                backgroundImageView.image = UIImage(named: "tennis_bg")
                
            }else if (sportName?.lowercased() == "basketball"){
            
                backgroundImageView.image = UIImage(named: "basketball_bg")
           
            }else if (sportName?.lowercased() == "cricket"){
                
                backgroundImageView.image = UIImage(named: "cricket_bg")
                
            }
                  
                
            cell.backgroundView = backgroundImageView
            
            return cell
            
        case 1:
            
            if latestEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCollectionViewCell
                
                cell.noDataimage.image = UIImage(named: "no_data")

                cell.noDatalabel.text = "No Past Events"
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventCollectionViewCell
            
            cell.configure(event: latestEvents[indexPath.item])
            
            let backgroundImageView = UIImageView(frame: cell.bounds)
                  
            backgroundImageView.contentMode = .scaleAspectFill
            
            backgroundImageView.clipsToBounds = true
            
            backgroundImageView.layer.cornerRadius = 15
            
            
            if(sportName?.lowercased() == "football"){
                
                backgroundImageView.image = UIImage(named: "soccer_bg")
                
            }else if (sportName?.lowercased() == "tennis"){
                
                backgroundImageView.image = UIImage(named: "tennis_bg")
                
            }else if (sportName?.lowercased() == "basketball"){
            
                backgroundImageView.image = UIImage(named: "basketball_bg")
           
            }else if (sportName?.lowercased() == "cricket"){
                
                backgroundImageView.image = UIImage(named: "cricket_bg")
                
            }
                  
                
            cell.backgroundView = backgroundImageView
            
            return cell
            
        case 2:
            
            if teams.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCollectionViewCell
                
                cell.noDataimage.image = UIImage(named: "no_data")

                cell.noDatalabel.text = "No Teams Found"
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            let team = teams[indexPath.item]
            
            cell.config(team: teams[indexPath.item])
            
            let backgroundImageView = UIImageView(frame: cell.bounds)
                  
            backgroundImageView.contentMode = .scaleAspectFill
            
            backgroundImageView.clipsToBounds = true
            
            backgroundImageView.layer.cornerRadius = 15
            
            
            if(sportName?.lowercased() == "football"){
                
                backgroundImageView.image = UIImage(named: "soccer_bg")
                
            }else if (sportName?.lowercased() == "tennis"){
                
                backgroundImageView.image = UIImage(named: "tennis_bg")
                
            }else if (sportName?.lowercased() == "basketball"){
            
                backgroundImageView.image = UIImage(named: "basketball_bg")
           
            }else if (sportName?.lowercased() == "cricket"){
                
                backgroundImageView.image = UIImage(named: "cricket_bg")
                
            }
                  
                
            cell.backgroundView = backgroundImageView
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            let teamVC = storyboard?.instantiateViewController(withIdentifier: "teamDetailsViewController") as! TeamDetailsViewController
            
            let selectedTeam = teams[indexPath.item]
            
            teamVC.myTeamKey = selectedTeam.teamKey
            
            teamVC.mysportName = sportName
            
            teamVC.teamName = selectedTeam.teamName
            
            
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
            self.networkIndicator.stopAnimating()
            
        }
        
    }
    
    func displayLatestEvents(events: [Event]) {
        
        self.latestEvents = events
        
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
            self.networkIndicator.stopAnimating()
            
        }
        
    }
    
    func displayTeams(teams: [Team]) {
        
        self.teams = teams
        
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
            self.networkIndicator.stopAnimating()
            
        }
        
    }
    
    func showError(message: String) {
        print("Error: \(message)")
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
}
