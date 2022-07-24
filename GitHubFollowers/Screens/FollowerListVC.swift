//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 16.07.2022.
//

import UIKit

protocol FollowerVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: GFDataLoadingVC {

    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    enum Section { case main }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var pageCounter: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchdController()
        getFollowers(username: username, page: pageCounter)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func configureSearchdController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addToFavoritesButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem = addToFavoritesButton
    }
    
    @objc func addToFavorites() {
        showLoading()
        
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func getFollowers(username: String, page: Int) {
        self.showLoading()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, view: self.view) }
                    return
                }
                
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
}


extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            pageCounter += 1
            getFollowers(username: username, page: pageCounter)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.delegate = self
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}



extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
    
}

extension FollowerListVC: FollowerVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        pageCounter = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: pageCounter)
        updateData(on: followers)
    }
}
