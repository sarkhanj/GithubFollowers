//
//  Follower.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/19/22.
//

import UIKit

struct Follower: Codable {
    var login: String
    var avatarUrl: String // there is a way to convert from snake case to camel case
}
