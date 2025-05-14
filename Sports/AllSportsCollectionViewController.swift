//
//  AllSportsCollectionViewController.swift
//  Sports
//
//  Created by Macos on 11/05/2025.
//

import UIKit

private let reuseIdentifier = "cell"

class AllSportsCollectionViewController: UICollectionViewController {
    
    var allSports: [Sport] = []
    
    var networkIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sports"
          
          
          let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
                                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
          navigationController?.navigationBar.titleTextAttributes = textAttributes
          
           
        allSports = [
                Sport(strSport: "Football", strSportThumb: "football.png"),
                Sport(strSport: "Tennis", strSportThumb: "tennis.png"),
                Sport(strSport: "Basketball", strSportThumb: "basketball.png"),
                Sport(strSport: "Cricket", strSportThumb: "cricket.png")
            ]
            
        

        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
            
            collectionView.reloadData()
        
    }
    
    func setActivityIndicator() {
        networkIndicator.center = view.center
        networkIndicator.color = .red
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
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
