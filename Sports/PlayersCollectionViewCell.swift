//
//  PlayersCollectionViewCell.swift
//  Sports
//
//  Created by Macos on 16/05/2025.
//

import UIKit
import Kingfisher

class PlayersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerRate: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
    
    func configure(with player: Player) {
            playerName.text = player.playerName ?? "Unknown"
            playerNumber.text = "#\(player.playerNumber ?? "Unknown")"
            playerAge.text = "Age: \(player.playerAge ?? "Unknown")"
        playerRate.text = "Rate: \(player.playerRating ?? "Unknown")"
            if let imageUrl = player.playerImage, let url = URL(string: imageUrl) {
                playerImage.kf.setImage(with: url)
            }
        }
    
//    if let ratingString = player.playerRating, let rating = Double(ratingString) {
//            playerRate.rating = rating
//        } else {
//            playerRate.rating = 0.0
//        }
//
//
//        if let imageUrl = player.playerImage, let url = URL(string: imageUrl) {
//            playerImage.kf.setImage(with: url)
//        }
}
