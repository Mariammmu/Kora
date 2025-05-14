//
//  AllSportsCollectionViewCell.swift
//  Sports
//
//  Created by Macos on 11/05/2025.
//

import UIKit

class AllSportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentContainer: UIView!
    
    @IBOutlet weak var sportImage: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        sportImage.layer.cornerRadius = 15
                sportImage.layer.masksToBounds = true
                sportImage.contentMode = .scaleAspectFill
                
                
                sportName.textAlignment = .center
                sportName.font = UIFont.boldSystemFont(ofSize: 14)
                sportName.textColor = .white
                sportName.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                sportName.layer.cornerRadius = 8
                sportName.layer.masksToBounds = true
                
                
                layer.cornerRadius = 15
                layer.masksToBounds = true
                layer.borderWidth = 2
                layer.borderColor = UIColor.systemBlue.cgColor
    }
    
}
