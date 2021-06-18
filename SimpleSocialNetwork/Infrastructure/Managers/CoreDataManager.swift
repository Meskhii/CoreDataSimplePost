//
//  CoreDataManager.swift
//  SimpleSocialNetwork
//
//  Created by user200328 on 6/18/21.
//


import UIKit
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    func register(with email: String, and password: String, completion: @escaping ((Bool) -> Void))
    func login(with email: String, and password: String, completion: @escaping ((Result<User?, UserError>) -> Void))
    func savePost(with post: Post, completion: @escaping ((Bool) -> Void))
    func fetchAllPosts(completion: @escaping ([Post]) -> Void)
    func fetchUserPosts(for user: User?, completion: @escaping ([Post]) -> Void)
    
    var context: NSManagedObjectContext? { get }
}

extension CoreDataManagerProtocol {
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    func register(with email: String, and password: String, completion: @escaping ((Bool) -> Void)) {
        guard let context = context else { return }
        let user = User(context: context)
        user.email = email
        user.password = password
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func login(with email: String, and password: String, completion: @escaping ((Result<User?, UserError>) -> Void)) {
        guard let context = context else { return }
        
        do {
            let predicate = NSPredicate(format: "(email = %@) AND (password = %@)", email, password)
            let request = NSFetchRequest<User>(entityName: "User")
            request.predicate = predicate
            
            let users = try context.fetch(request)
            
            if let last = users.last {
                completion(.success(last))
            } else {
                completion(.failure(.userNotFound))
            }
            
        } catch {
            completion(.failure(.unknownError))
        }
    }

    func savePost(with post: Post, completion: @escaping ((Bool) -> Void)) {
        guard let context = context else { return }

        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func fetchAllPosts(completion: @escaping ([Post]) -> Void) {
        guard let context = context else { return }

        do {
            let request = NSFetchRequest<Post>(entityName: "Post")
            
            let posts = try context.fetch(request)
            completion(posts)
            
        } catch {
            completion([])
        }
    }

    func fetchUserPosts(for user: User?, completion: @escaping ([Post]) -> Void) {
        guard let context = context,
              let user = user else { return }

        do {
            let predicate = NSPredicate(format: "user == %@", user)
            let request = NSFetchRequest<Post>(entityName: "Post")
            request.predicate = predicate

            let emails = try context.fetch(request)
            completion(emails)
        } catch {
            completion([])
        }
        
    }
    
}

enum UserError: Error {
    case userNotFound
    case unknownError
}

