//
//  TeamsCollectionViewCell.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import Kingfisher

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    
    
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        
        setupViews()
    
    }
   
    func setupViews() {
            
            backgroundColor = .white
            layer.cornerRadius = 15
            layer.masksToBounds = true
            layer.borderWidth = 2
            layer.borderColor = UIColor(hex: "#C12A44").cgColor
    }
    
    public func config(team:Team){
        
        teamName.text = team.teamName
        
        if let teamLogo = team.teamLogo, let url = URL(string: teamLogo) {
            teamImage.kf.setImage(with: url, placeholder: UIImage(named: "team_logo"))
        } else {
            teamImage.image = UIImage(named: "team_logo")
        }
      
        
    }
}
