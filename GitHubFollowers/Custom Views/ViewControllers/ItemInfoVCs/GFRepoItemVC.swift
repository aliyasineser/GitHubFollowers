//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 22.07.2022.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGithubProfiler(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
 
    var user: User!
    
    weak var delegate: GFRepoItemVCDelegate!
    
    init(for user: User, delegate: GFRepoItemVCDelegate) {
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
        itemInfoOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(color: .systemPurple, title: "GitHub profile", systemImageName: "person")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfiler(for: user)
    }
    
}
