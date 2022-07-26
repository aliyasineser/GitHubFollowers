//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 22.07.2022.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
 
    var user: User!
    
    weak var delegate: GFFollowerItemVCDelegate!
    
    init(for user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.delegate = delegate
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
