//
//  File.swift
//  SimpleSocialNetwork
//
//  Created by user200328 on 6/18/21.
//

import Foundation

protocol EditPostViewModelProtocol: AnyObject {
    func fetchAllPosts(completion: @escaping ([Post]) -> Void)
    
    init(with coreDataManager: CoreDataManagerProtocol)
}

final class EditPostViewModel: EditPostViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(with coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchAllPosts(completion: @escaping ([Post]) -> Void) {
        coreDataManager.fetchAllPosts(completion: completion)
    }
    
    
}
