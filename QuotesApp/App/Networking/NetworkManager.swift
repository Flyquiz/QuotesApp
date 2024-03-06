//
//  NetworkManager.swift
//  QuotesApp
//
//  Created by Иван Захаров on 06.03.2024.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    private init() {}
    
    
    public func fetchQuotes(for category: Category, completion: @escaping (Result<Quote, NetworkError>) -> ()) {
        let categoryStr = category.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=" + categoryStr)!
        
        var request = URLRequest(url: url)
//        request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, let response = response as? HTTPURLResponse else {
                sendError(error: .dataTaskError)
                return
            }
            print(response.statusCode)
            
            switch response.statusCode {
            case 200...299:
                do {
                    let quote = try self.decoder.decode(Quote.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(quote))
                    }
                } catch {
                    sendError(error: .decodingError)
                }
              
            case 400:
                sendError(error: .badRequest)
            case 401:
                sendError(error: .authError)
            case 403:
                sendError(error: .forbidden)
            case 404:
                sendError(error: .notFound)
            default:
                return
            }
        }.resume()
        
        func sendError(error: NetworkError) {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}



enum NetworkError: Error {
    case badRequest
    case authError
    case forbidden
    case notFound
    case decodingError
    case dataTaskError
    
    var title: String {
        switch self {
        case .badRequest:
            return "Network error - 400: Can't get data, bad request"
        case .authError:
            return "Network error - 401: Wrong authorization key for API"
        case .forbidden:
            return "Network error - 403: Forbidden. Can't get access, check API key"
        case .notFound:
            return "Network error - 404: Can't get data, not found"
        case .decodingError:
            return "Internal error (network): Can't decode data"
        case .dataTaskError:
            return "Internal error (network): Can't start dataTask"
        }
    }
}
