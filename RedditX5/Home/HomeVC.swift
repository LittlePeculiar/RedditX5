//
//  HomeVC.swift
//  RedditX5
//
//  Created by Gina Mullins on 10/30/20.
//

import UIKit

class HomeVC: UIViewController {
    
    private let viewModel: HomeVM
    private let tableView: UITableView = UITableView()
    
    init(with viewModel: HomeVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        viewModel.dataDidChange {
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    func setupUI() {
        self.title = viewModel.title
        
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseID)

        // make row height dynamic
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 75
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        setupLayout()
    }
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell, indexPath.row < viewModel.numberOfPosts else { return UITableViewCell() }
        let post = viewModel.redditPosts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    
}
