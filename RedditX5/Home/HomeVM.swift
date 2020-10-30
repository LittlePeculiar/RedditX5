//
//  HomeVM.swift
//  RedditX5
//
//  Created by Gina Mullins on 10/30/20.
//

import UIKit

protocol HomeVMContract {
    var redditPosts: [Reddit] { get }
    var isLoading: Bool { get }
    var title: String { get }
    var numberOfPosts: Int { get }
    
    func dataDidChange(callback: @escaping () -> Void)
}

class HomeVM: HomeVMContract {
    
    // MARK: Private
    
    private var dataDidChangeClosure: (() -> Void)?
    private let api: API
    
    // MARK: Public
    
    var redditPosts: [Reddit] = [] {
        didSet {
            dataDidChangeClosure?()
        }
    }
    var isLoading: Bool = false
    var title: String = "Reddit"
    var numberOfPosts: Int {
        redditPosts.count
    }
    
    func dataDidChange(callback: @escaping () -> Void) {
        dataDidChangeClosure = callback
    }
    
    func fetchRedditPosts() {
        isLoading = true
        
        api.fetchRedditPosts { [weak self](results) in
            self?.isLoading = false
            switch results {
            case .failure(_):
                print("failed to fetch reddit posts")
                self?.redditPosts.removeAll()
                
            case .success(let posts):
                print("success: \(posts.count) records")
                self?.redditPosts = posts
            }
        }
    }
    
    // MARK: init
    init(with api: API) {
        self.api = api
        fetchRedditPosts()
    }
}
