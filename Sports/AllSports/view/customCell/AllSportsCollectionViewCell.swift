//
//  AllSportsCollectionViewCell.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class AllSportsCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet weak var sportImage: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        sportImage.layer.cornerRadius = 15
        sportImage.layer.masksToBounds = true
        sportImage.contentMode = .scaleAspectFill
        sportName.layer.cornerRadius = 8
        sportName.layer.masksToBounds = true
                
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor(hex: "#C12A44").cgColor
    }
}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
