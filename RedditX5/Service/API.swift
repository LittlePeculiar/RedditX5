//
//  API.swift
//  RedditX5
//
//  Created by Gina Mullins on 10/30/20.
//

import UIKit

enum FetchErrors: Error {
    case invalidURL
    case responseFailure
    case noData
    case serializationError
}

enum Constants {
    static let baseURL = "https://www.reddit.com/.json"
}

protocol APIContract {
    func fetchRedditPosts(completion: @escaping (Swift.Result<[Reddit], FetchErrors>) -> Void)
}

class API: NSObject {
    
    let session = URLSession.shared
    
    
    func fetchRedditPosts(completion: @escaping (Swift.Result<[Reddit], FetchErrors>) -> Void) {
        guard let url = URL(string: Constants.baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.responseFailure))
                return
            }
            guard let postData = data else {
                completion(.failure(.noData))
                return
            }
            guard let container = try? JSONDecoder().decode(Children.self, from: postData) else {
                completion(.failure(.serializationError))
                return
            }
            completion(.success(container.children))
        }.resume() // dont forget this
    }
}
