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

        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
     

}
