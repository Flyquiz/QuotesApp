//
//  Category.swift
//  QuotesApp
//
//  Created by Иван Захаров on 05.03.2024.
//

import Foundation

struct Category {
    let name: String
}

extension Category {
    static func makeModel() -> [Category] {
        let stringArr = ["age",
                     "alone",
                     "amazing",
                     "anger",
                     "architecture",
                     "art",
                     "attitude",
                     "beauty",
                     "best",
                     "birthday",
                     "business",
                     "car",
                     "change",
                     "communication",
                     "computers",
                     "cool",
                     "courage",
                     "dad",
                     "dating",
                     "death",
                     "design",
                     "dreams",
                     "education",
                     "environmental",
                     "equality",
                     "experience",
                     "failure",
                     "faith",
                     "family",
                     "famous",
                     "fear",
                     "fitness",
                     "food",
                     "forgiveness",
                     "freedom",
                     "friendship",
                     "funny",
                     "future",
                     "god",
                     "good",
                     "government",
                     "graduation",
                     "great",
                     "happiness",
                     "health",
                     "history",
                     "home",
                     "hope",
                     "humor",
                     "imagination",
                     "inspirational",
                     "intelligence",
                     "jealousy",
                     "knowledge",
                     "leadership",
                     "learning",
                     "legal",
                     "life",
                     "love",
                     "marriage",
                     "medical",
                     "men",
                     "mom",
                     "money",
                     "morning",
                     "movies",
                     "success"]
        var model: [Category] = []
        for string in stringArr {
            let category = Category(name: string)
            model.append(category)
        }
        return model
    }
}
