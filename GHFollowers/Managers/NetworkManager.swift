//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/20/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl = "https://api.github.com/user/"
    
    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseUrl + username + "/followers"
    }
}
