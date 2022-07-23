//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 22.07.2022.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
 
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
        itemInfoOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfiler(for: user)
    }
    
}
