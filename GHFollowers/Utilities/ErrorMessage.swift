//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/20/22.
//

import Foundation

enum GFError: String, Error {
    case userDoesntExist = "The user with a given username doesn't exist. Please try another username."
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse =  "Invalide response from the server. Please try again."
    case invalidData = "The data received from server was invalid. Please try again."
}
