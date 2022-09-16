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
        navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.tintColor = .label
        

        // Do any additional setup after loading the view.
    }
     

}
