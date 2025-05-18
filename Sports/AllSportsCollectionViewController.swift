//
//  AllSportsCollectionViewController.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit

private let reuseIdentifier = "cell"

class AllSportsCollectionViewController: UICollectionViewController {

    var allSports: [Sport] = []
    
    var networkIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sports"
          
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: "#C12A44"),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let backgroundImage = UIImageView(image: UIImage(named: "bg"))
        backgroundImage.contentMode = .scaleAspectFill
           backgroundImage.frame = self.collectionView.bounds
           
           
           self.collectionView.backgroundView = backgroundImage
          
           
        allSports = [
                Sport(strSport: "Football", strSportThumb: "football_home.png"),
                Sport(strSport: "Tennis", strSportThumb: "tennis_home.png"),
                Sport(strSport: "Cricket", strSportThumb: "cricket_home.png"),
                Sport(strSport: "Basketball", strSportThumb: "basketball_home.png")
            ]
            
        

        collectionView.contentInset = UIEdgeInsets(top: 50, left: 15, bottom: 0, right: 15)
            
            collectionView.reloadData()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSports.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AllSportsCollectionViewCell
           
        let sport = allSports[indexPath.row]
        cell.sportName.text = sport.strSport
        cell.sportImage.image = UIImage(named: sport.strSportThumb)
           
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedSport = allSports[indexPath.row].strSport.lowercased()
        
        let leagueVC = storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueTableViewController
        
        leagueVC.selectedSport = selectedSport
        
        navigationController?.pushViewController(leagueVC, animated: true)
    }

    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        let spacing: CGFloat = 10
        let width = (totalWidth - spacing) / 2
        let height = width * 0.7
        return CGSize(width: width, height: height)
    }

    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }


}
