//
//  CollectionViewCell.swift
//  QuotesApp
//
//  Created by Иван Захаров on 07.03.2024.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quote"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Author"
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //    }
    //    @available(*, unavailable)
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    public func setupCell(quote: Quote?) {
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 20
        [quoteLabel,
         authorLabel,
         categoryLabel].forEach{ contentView.addSubview($0) }
        
        let inset: CGFloat = 10
        var bottomInset: CGFloat {
            return authorLabel.intrinsicContentSize.height + inset * 2
        }
        
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            quoteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomInset),
            
            
            authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            
            categoryLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: inset),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
        
        guard let quote else { return }
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
        categoryLabel.text = quote.category
    }
}
