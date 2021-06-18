//
//  PostsDataSource.swift
//  SimpleSocialNetwork
//
//  Created by Admin on 17.06.2021.
//

import UIKit


class PostsDataSource: NSObject {
    
    // MARK: - Variables
    private var tableView: UITableView!
    private var viewModel: PostsViewModelProtocol!
    private var postsList = [Post]()
    private var userPostsList = [Post]()
    private var postsViewController: PostsViewController!
    
    // MARK: - Init
    init(with tableView: UITableView, viewModel: PostsViewModelProtocol, postsViewController: PostsViewController) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.viewModel = viewModel
        self.postsViewController = postsViewController
    }
    
    // MARK: - Fetcher
    func refresh() {
        fetchAllPosts()
    }
    
    func fetchAllPosts() {
        viewModel.fetchAllPosts() { posts in
            self.postsList = posts
            self.tableView.reloadData()
        }
    }
    
    func fetchUserPosts() {
        viewModel.fetchUserPosts(for: viewModel.user) { posts in
            self.userPostsList = posts
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableView Data Source & Delegate
extension PostsDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(PostCell.self, for: indexPath)
        cell.configure(with: postsList,
                       and: indexPath.row,
                       user: viewModel.user!)
        cell.delegate = postsViewController
        return cell
    }
    
}
