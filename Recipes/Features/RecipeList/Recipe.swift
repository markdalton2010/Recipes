//
//  Recipe.swift
//  Recipes
//
//  Created by Mark Dalton on 5/29/25.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let id: UUID
    let name: String
    let cuisine: String
    let photo_url_small: String?
    let photo_url_large: String?
    let source_url: String?
    let youtube_url: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photo_url_small
        case photo_url_large
        case source_url
        case youtube_url
    }
}
