//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/22/22.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemOneView = UIView()
    let itemTwoView = UIView()
    var itemViews: [UIView] = []
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getUserInfo()
    }
    

    
    func configureVC(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: UserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func layoutUI(){
        itemViews = [headerView, itemOneView, itemTwoView]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
               item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
               item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
    
        itemOneView.backgroundColor = .systemPink
        itemTwoView.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOneView.heightAnchor.constraint(equalToConstant: itemHeight),

            itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: padding),
            itemTwoView.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
