//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/20/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl = "https://api.github.com/users/"
    
    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let userEndpoint = baseUrl + "\(username)"
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let userUrl = URL(string: userEndpoint) else {
            completed(.failure(.userDoesntExist))
            return
        }
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        // get followers array
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let followers = try! decoder.decode([Follower].self, from: data)
            completed(.success(followers))
            
        }

        
        // check if the user exists
        let userTask = URLSession.shared.dataTask(with: userUrl) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.userDoesntExist))
                return
            }
            
            if let error = error {
                print(error)
            }else{
                task.resume()
            }
            
        }
        
        userTask.resume()
        
               
    }
}
