//
//  ViewController.swift
//  QuotesApp
//
//  Created by Иван Захаров on 04.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private let tableModel: [Category] = Category.makeModel()
    
    private lazy var searchController: UISearchController = {
        let searchVC = UISearchController()
        searchVC.delegate = self
        searchVC.searchBar.placeholder = "Get random quote from category bellow"
        return searchVC
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    
    private func setup() {
        navigationItem.title = "QuotesApp"
        view.backgroundColor = .systemGray6
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}



//MARK: - tableView dataSource/delegate
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.identifier)
        
        var content = cell.defaultContentConfiguration()
        content.text = tableModel[indexPath.row].name
        content.textProperties.color = .black
        cell.contentConfiguration = content
        
        cell.isUserInteractionEnabled = false
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}



//MARK: - Search delegates

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
}
