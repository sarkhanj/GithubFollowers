//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/16/22.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result{
            case .success(let followers):
                print(followers.count)
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "test message", message: error.rawValue, buttonTitle: "Ok")
            }
            
            
        }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
     

}
