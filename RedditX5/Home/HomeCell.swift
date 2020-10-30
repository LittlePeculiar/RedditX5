//
//  HomeCell.swift
//  RedditX5
//
//  Created by Gina Mullins on 10/30/20.
//

import UIKit

class HomeCell: UITableViewCell {

    static let reuseID = "HomeCell"
    
    private let subnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let postLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius =  10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with post: Reddit) {
        subnameLabel.text = post.subreddit
        postLabel.text = post.title
        thumbnailImageView.fetchImage(withURL: post.thumbnailURL)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(subnameLabel)
        self.addSubview(postLabel)
        self.addSubview(thumbnailImageView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        subnameLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor).isActive = true
        subnameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10).isActive = true
        subnameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        subnameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        postLabel.topAnchor.constraint(equalTo: subnameLabel.bottomAnchor, constant: 5).isActive = true
        postLabel.leadingAnchor.constraint(equalTo: subnameLabel.leadingAnchor).isActive = true
        postLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        postLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
