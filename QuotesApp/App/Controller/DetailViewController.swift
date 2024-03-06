//
//  DetailViewController.swift
//  QuotesApp
//
//  Created by Иван Захаров on 07.03.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "quote"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 5
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
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
        categoryLabel.text = quote.category
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        view.backgroundColor = .systemGray6
        [quoteLabel,
         authorLabel,
         categoryLabel].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 20
        NSLayoutConstraint.activate([
            //TODO: Fix numberOfLines
            quoteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            quoteLabel.heightAnchor.constraint(equalToConstant: quoteLabel.intrinsicContentSize.height),
            
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 10),
            
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 40),
        ])
    }
}
