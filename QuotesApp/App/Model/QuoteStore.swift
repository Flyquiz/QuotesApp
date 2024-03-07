//
//  QuoteStore.swift
//  QuotesApp
//
//  Created by Иван Захаров on 07.03.2024.
//

import UIKit

final class QuoteStore {
    
    static let shared = QuoteStore()
    
    private var favoritesArray: [Quote] = []
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard
    
    
    private init() {
        let data = userDefaults.object(forKey: "quotes") as? Data
        guard let data else {
            print("Internal error: Can't get data for decoding in QuoteStore")
            return
        }
        do {
            let decoded = try decoder.decode(QuoteQuery.self, from: data)
            self.favoritesArray = decoded
        } catch {
            print("Internal error: Can't decode data in QuoteStore")
            return
        }
    }
    
    private func encode() {
        do {
            let encoded = try encoder.encode(favoritesArray)
            userDefaults.setValue(encoded, forKey: "quotes")
        } catch {
            print("Internal error: Can't encode data in QuoteStore")
        }
    }
    
    public func save(quote: Quote) {
        favoritesArray.append(quote)
        encode()
    }
    
    public func delete(quote: Quote, index: Int) {
        favoritesArray.remove(at: index)
        encode()
    }
    
    public func getStorage() -> [Quote] {
        favoritesArray
    }
}
