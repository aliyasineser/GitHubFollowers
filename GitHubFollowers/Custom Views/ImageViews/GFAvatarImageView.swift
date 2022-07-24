//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 17.07.2022.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholderImage: UIImage = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
