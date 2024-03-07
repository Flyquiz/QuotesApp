//
//  DetailViewController.swift
//  QuotesApp
//
//  Created by Иван Захаров on 07.03.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let quoteStore = QuoteStore.shared
    
    private let currentQuote: Quote
    
    private var isFavorite: Bool
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "quote"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "author"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "category"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    init(quote: Quote) {
        currentQuote = quote
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
        categoryLabel.text = quote.category
        isFavorite = quote.isFavorite ?? false
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayout()
    }
    
    
    private func setupNavigationBar() {
        let favoritesButton = UIBarButtonItem(image: nil,
                                              style: .done,
                                              target: self, 
                                              action: #selector(favoriteAction))
        if isFavorite {
            favoritesButton.image = UIImage(systemName: "star.fill")
            favoritesButton.tintColor = .systemYellow
        } else {
            favoritesButton.image = UIImage(systemName: "star")
        }
        
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), 
                                            style: .done,
                                            target: self,
                                            action: #selector(refreshAction))
        navigationItem.rightBarButtonItems = [favoritesButton, refreshButton]
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        [quoteLabel,
         authorLabel,
         categoryLabel].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 20
        NSLayoutConstraint.activate([
            quoteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            quoteLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 10),
            
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 40),
        ])
    }
    
    @objc private func favoriteAction() {
        guard let favoriteButton = navigationItem.rightBarButtonItems?[0] else { return }
        let fillImage = UIImage(systemName: "star.fill")
        switch isFavorite {
            
        case true:
            quoteStore.delete(quote: currentQuote, index: nil)
            let image = UIImage(systemName: "star")!
            favoriteButton.setSymbolImage(image, contentTransition: .replace)
            favoriteButton.tintColor = .systemBlue
            isFavorite.toggle()
        case false:
            quoteStore.save(quote: currentQuote)
            let image = UIImage(systemName: "star.fill")!
            favoriteButton.setSymbolImage(image, contentTransition: .replace)
            favoriteButton.tintColor = .systemYellow
            isFavorite.toggle()
        }
    }
    
    @objc private func refreshAction() {
        
    }
}
