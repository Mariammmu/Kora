//
//  LatestEventCollectionViewCell.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LatestEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var team1Image: UIImageView!
    
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
    
    @IBOutlet weak var team2Name: UILabel!
    
    @IBOutlet weak var finalResult: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           setupViews()
       }
    func setupViews() {
            
            
            backgroundColor = .white
            
            
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray.cgColor
            layer.cornerRadius = 8
    
    }
    
    public func configure(event: Event) {
        team1Name.text = event.eventHomeTeam ?? "N/A"
        team2Name.text = event.eventAwayTeam ?? "N/A"
        finalResult.text = event.eventFinalResult ?? "-"
        date.text = event.eventDate ?? "N/A"
        time.text = event.eventTime ?? "N/A"
        
        if let homeLogo = event.homeTeamLogo, let url = URL(string: homeLogo) {
            team1Image.kf.setImage(with: url)
        } else {
            team1Image.image = UIImage(systemName: "questionmark")
        }
        
        if let awayLogo = event.awayTeamLogo, let url = URL(string: awayLogo) {
            team2Image.kf.setImage(with: url)
        } else {
            team2Image.image = UIImage(systemName: "questionmark")
        }
    }
}
