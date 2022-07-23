//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 22.07.2022.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
 
    var user: User!
    
    init(for user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoTwo.set(itemInfoType: .following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
