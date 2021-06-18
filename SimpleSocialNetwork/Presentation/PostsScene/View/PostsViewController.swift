//
//  PostsViewController.swift
//  SimpleSocialNetwork
//
//  Created by Admin on 17.06.2021.
//

import UIKit

protocol PostsViewControllerProtocol: AnyObject {
    func editTapped(index: Int)
}

class PostsViewController: UIViewController {
    
    // MARK: - Variables
    private var dataSource: PostsDataSource!
    private var viewModel: PostsViewModelProtocol!
    var user: User?

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        tableView.registerNib(class: PostCell.self)
        
        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataSource.refresh()
    }
    
    // MARK: - View Model Configuration
    private func configureViewModel() {
        viewModel = PostsViewModel(with: CoreDataManager(), user: user)
        dataSource = PostsDataSource(with: tableView, viewModel: viewModel, postsViewController: self)
        
        dataSource.refresh()
    }
    
    // MARK: - IBActions
    @IBAction func addPostTapped(_ sender: Any) {
        navigateToAddPost(with: user)
    }
    
    // MARK: - Navigation
    private func navigateToAddPost(with user: User?) {
        let sb = UIStoryboard(name: VCIds.addPostVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.addPostVC) as! AddPostViewController
       
        vc.user = user
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: PostsViewControllerProtocol
extension PostsViewController: PostsViewControllerProtocol {
    func editTapped(index: Int) {
        let sb = UIStoryboard(name: VCIds.editPostVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.editPostVC) as! EditPostViewController
        
        vc.postIndex = index
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
