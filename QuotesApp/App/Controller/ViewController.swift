//
//  ViewController.swift
//  QuotesApp
//
//  Created by Иван Захаров on 04.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    private var tableModel: [Category] = []
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select a random category below and we will give you a random quote"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableModel = Category.makeModel()
        setupNavigationBar()
        setupLayout()
    }

    private func setupNavigationBar() {
        navigationItem.title = "QuotesApp"
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), 
                                              style: .done,
                                              target: self,
                                              action: #selector(favoriteAction))
        favoritesButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = favoritesButton
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        view.addSubview(mainLabel)
        
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: inset),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset)
        ])
    }
    
    @objc private func favoriteAction() {
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
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
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = tableModel[indexPath.row]
        networkManager.fetchQuotes(for: category) { [weak self] result in
            switch result {
            case .success(let quote):
                let detailVC = DetailViewController(quote: quote)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            case .failure(let error):
                print(error.title)
            }
        }
    }
}
