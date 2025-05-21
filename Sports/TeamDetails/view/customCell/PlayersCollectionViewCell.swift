//
//  PlayersCollectionViewCell.swift
//  Sports
//
//  Created by Macos on 16/05/2025.
//

import UIKit
import Kingfisher
import Cosmos

class PlayersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerImage: UIImageView!
    

    @IBOutlet weak var playerRate: CosmosView!
    
    @IBOutlet weak var playerAge: UILabel!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    
    }
    
    func configure(with player: Player) {
        
            playerName.text = player.playerName ?? "Unknown"
            playerNumber.text = "#\(player.playerNumber ?? "Unknown")"
            playerAge.text = "Age: \(player.playerAge ?? "Unknown")"
        
        
        if let ratingString = player.playerRating, let rating = Double(ratingString) {
                playerRate.rating = rating
            } else {
                playerRate.rating = 0.0
            }

     
            if let imageUrl = player.playerImage, let url = URL(string: imageUrl) {
                playerImage.kf.setImage(with: url , placeholder: UIImage(named: "unknown-player"))
            }
        else {
                self.playerImage.image = UIImage(named: "unknown-player")
            }
        
        }
    
    func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor(hex: "#C12A44").cgColor
        
        
        playerRate.isUserInteractionEnabled = false
        

        playerRate.settings.fillMode = .precise
        playerRate.settings.starSize = 20
        playerRate.settings.starMargin = 5
    }

    
 
}
