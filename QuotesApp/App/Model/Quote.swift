//
//  Quote.swift
//  QuotesApp
//
//  Created by Иван Захаров on 06.03.2024.
//

import Foundation

typealias QuoteQuery = [Quote]

struct Quote: Decodable {
    let quote: String
    let author: String
    let category: String
}
