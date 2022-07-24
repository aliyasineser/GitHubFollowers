//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 25.07.2022.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor  = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
