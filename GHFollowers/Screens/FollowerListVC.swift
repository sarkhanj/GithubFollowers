//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/16/22.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page: Int = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: userName, page: page)
        configureDataSource()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
            guard let self = self else { return }
//            #warning("dismiss loading")
            self.dismissLoadingView()

            switch result{
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Please follow them."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, for: self.view)
                    }
                    return
                }
                
                self.updateData(on: followers)

            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "test message", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
   
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
     
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: itemIdentifier)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    func configureSearchBar(){
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter username"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
        
        
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}
