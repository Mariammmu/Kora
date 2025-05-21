//
//  FavLeagueTableViewCell.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class FavLeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var favLeagueImage: UIImageView!
    
    @IBOutlet weak var favLeagueName: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favLeagueImage.layer.cornerRadius = favLeagueImage.frame.size.width / 2
        favLeagueImage.clipsToBounds = true
        
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
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
