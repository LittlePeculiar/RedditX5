//
//  Reddit.swift
//  RedditX5
//
//  Created by Gina Mullins on 10/30/20.
//

import Foundation

private struct RedditContainer: Decodable {
    struct Data: Decodable {
        var children: [Reddit]
    }
    var data: Data
}

struct Children: Decodable {
    var children: [Reddit]
    
    init(from decoder: Decoder) throws {
        let container = try RedditContainer.init(from: decoder)
        children = container.data.children
    }
}

struct Reddit: Decodable {
    var subreddit: String
    var title: String
    var thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case subreddit
        case title
        case thumbnail
        case data
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try mainContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        subreddit = try container.decode(String.self, forKey: .subreddit)
        title = try container.decode(String.self, forKey: .title)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
    
    var thumbnailURL: URL? {
        return URL(string: thumbnail)
    }
}
