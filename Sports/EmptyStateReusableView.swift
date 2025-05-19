//
//  EmptyStateReusableView.swift
//  Sports
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class EmptyStateReusableView: UICollectionReusableView {
   
    static let reuseIdentifier = "EmptyStateView"
        
        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let messageLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(imageView)
            addSubview(messageLabel)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                imageView.widthAnchor.constraint(equalToConstant: 150),
                imageView.heightAnchor.constraint(equalToConstant: 150),
                
                messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(imageName: String, message: String) {
            imageView.image = UIImage(named: imageName)
            messageLabel.text = message
        }
    }
