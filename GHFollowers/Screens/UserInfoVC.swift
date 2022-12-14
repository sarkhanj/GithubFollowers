//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/22/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemOneView = UIView()
    let itemTwoView = UIView()
    let dateLabel = GFBodyLabel(textAlingment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
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
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        self.add(childVC: repoItemVC, to: self.itemOneView)
        
        let followerItemVC = GFFollowersItemVC(user: user)
        followerItemVC.delegate = self
        self.add(childVC: followerItemVC, to: self.itemTwoView)
        
        self.add(childVC: UserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"

    }
    
    func layoutUI(){
        itemViews = [headerView, itemOneView, itemTwoView, dateLabel]
        
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

        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOneView.heightAnchor.constraint(equalToConstant: itemHeight),

            itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: padding),
            itemTwoView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemTwoView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Zero Followers", message: "The user doesn't have any followers", buttonTitle: "sad")
            return
        }
        dismissVC()     
        delegate.didRequestFollowers(for: user.login)
    }    

}
