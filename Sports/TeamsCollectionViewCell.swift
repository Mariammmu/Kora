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
    
    public func config(teamTitle:String, teamImg:String){
        
        teamName.text = teamTitle
        teamImage.kf.setImage(with: URL(string: teamImg))
        
    }
}
