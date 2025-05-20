//
//  LeagueTableViewCell.swift
//  Sports
//
//  Created by Macos on 12/05/2025.
//

import UIKit
import ShimmerSwift
class LeagueTableViewCell: UITableViewCell {

  
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    let shimmerView = ShimmeringView()
    let placeholderView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leagueImage.layer.cornerRadius = leagueImage.frame.size.width / 2
            leagueImage.clipsToBounds = true
        
        setupShimmer()
        
        containerView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true

        containerView.layer.masksToBounds = true
    }
    

    override func layoutSubviews() {
            super.layoutSubviews()
            
            let spacing: CGFloat = 6
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: spacing, left: 16, bottom: spacing, right: 16))
            
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
        }
    
    private func setupShimmer() {
        placeholderView.backgroundColor = .systemGray5
        placeholderView.layer.cornerRadius = leagueImage.frame.size.width / 2
        placeholderView.clipsToBounds = true
        placeholderView.translatesAutoresizingMaskIntoConstraints = false

        shimmerView.contentView = placeholderView
        shimmerView.isShimmering = false
        shimmerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(shimmerView)

        NSLayoutConstraint.activate([
            shimmerView.leadingAnchor.constraint(equalTo: leagueImage.leadingAnchor),
            shimmerView.trailingAnchor.constraint(equalTo: leagueImage.trailingAnchor),
            shimmerView.topAnchor.constraint(equalTo: leagueImage.topAnchor),
            shimmerView.bottomAnchor.constraint(equalTo: leagueImage.bottomAnchor)
        ])
    }

    func startShimmering() {
        shimmerView.isShimmering = true
        shimmerView.isHidden = false
        leagueImage.isHidden = true
    }

    func stopShimmering() {
        shimmerView.isShimmering = false
        shimmerView.isHidden = true
        leagueImage.isHidden = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

