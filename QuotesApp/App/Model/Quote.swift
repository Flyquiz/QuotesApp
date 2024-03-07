//
//  Quote.swift
//  QuotesApp
//
//  Created by Иван Захаров on 06.03.2024.
//

import Foundation

typealias QuoteQuery = [Quote]

struct Quote: Codable {
    let quote: String
    let author: String
    let category: String
    var isFavorite: Bool?
}

extension Quote: Equatable {
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        lhs.quote == rhs.quote &&
        lhs.author == rhs.author &&
        lhs.category == rhs.category
    }
}
