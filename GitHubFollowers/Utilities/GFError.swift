//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 20.07.2022.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid Request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "This user is already in your favorites."
}

