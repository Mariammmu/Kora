//
//  LeagueTableViewCell.swift
//  Sports
//
//  Created by Macos on 12/05/2025.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

  
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leagueImage.layer.cornerRadius = leagueImage.frame.size.width / 2
            leagueImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
