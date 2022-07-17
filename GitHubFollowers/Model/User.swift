//
//  User.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 17.07.2022.
//

import Foundation
    
struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var bio: String?
    var email: String?
    var location: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
    
}
