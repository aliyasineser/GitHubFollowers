//
//  User.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 17.07.2022.
//

import Foundation
    
struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var bio: String?
    var email: String?
    var location: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
    
}
