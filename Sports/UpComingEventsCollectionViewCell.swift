//
//  UpComingEventsCollectionViewCell.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import Kingfisher
import ShimmerSwift

class UpComingEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var team1Image: UIImageView!
    
    
    @IBOutlet weak var team2Image: UIImageView!
    
    @IBOutlet weak var team1Name: UILabel!
    
    @IBOutlet weak var team2Name: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    
    let shimmeringView = ShimmeringView()

    override func awakeFromNib() {
           super.awakeFromNib()
           setupViews()
        setupShimmerView()
       }
    
    func setupViews() {
            
            
            backgroundColor = .white
            
            
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray.cgColor
            layer.cornerRadius = 8
    
    }
    private func setupShimmerView() {
          shimmeringView.frame = contentView.bounds
          shimmeringView.contentView = contentView

          let placeholderView = UIView(frame: contentView.bounds)
          placeholderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
          shimmeringView.contentView.addSubview(placeholderView)
          
          shimmeringView.isShimmering = true
          shimmeringView.shimmerSpeed = 150
          
          contentView.addSubview(shimmeringView)
      }
    
    
    public func configure(event: Event) {
        team1Name.text = event.eventHomeTeam ?? "N/A"
        team2Name.text = event.eventAwayTeam ?? "N/A"
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
        shimmeringView.isShimmering = false
    }
    
    func startShimmering() {
            shimmeringView.isShimmering = true
        }

        func stopShimmering() {
            shimmeringView.isShimmering = false
        }

}
