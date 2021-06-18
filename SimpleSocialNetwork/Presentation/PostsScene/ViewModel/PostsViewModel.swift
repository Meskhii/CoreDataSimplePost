//
//  PostsViewModel.swift
//  SimpleSocialNetwork
//
//  Created by user200328 on 6/18/21.
//

import Foundation

protocol PostsViewModelProtocol: AnyObject {
    func fetchAllPosts(completion: @escaping ([Post]) -> Void)
    func fetchUserPosts(for user: User?, completion: @escaping ([Post]) -> Void)
    
    var user: User? { get }
    
    init(with coreDataManager: CoreDataManagerProtocol, user: User?)
}

final class PostsViewModel: PostsViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    private(set) var user: User?
    
    init(with coreDataManager: CoreDataManagerProtocol, user: User?) {
        self.coreDataManager = coreDataManager
        self.user = user
    }
    
    func fetchAllPosts(completion: @escaping ([Post]) -> Void) {
        coreDataManager.fetchAllPosts(completion: completion)
    }
    
    func fetchUserPosts(for user: User?, completion: @escaping ([Post]) -> Void) {
        coreDataManager.fetchUserPosts(for: user, completion: completion)
    }
    
}

