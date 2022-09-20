//
//  User.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/19/22.
//

import UIKit

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String? // user might not have put that
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
