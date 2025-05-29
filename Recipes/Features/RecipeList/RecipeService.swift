//
//  Untitled.swift
//  Recipes
//
//  Created by Mark Dalton on 5/29/25.
//

import Foundation

enum RecipeServiceError: Error {
    case invalidURL
    case decodingError
    case networkError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .decodingError:
            return "We couldn’t load the recipes. Please try again later."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

enum RecipeEndpoint {
    case normal
    case malformed
    case empty

    var url: URL? {
        switch self {
        case .normal:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        case .malformed:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        case .empty:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        }
    }
}

final class RecipeService {
    private let endpoint: RecipeEndpoint
    
    init(endpoint: RecipeEndpoint = .normal) {
        self.endpoint = endpoint
    }
    
    func getRecipes() async throws -> [Recipe] {
        do {
            guard let url = endpoint.url else {
                throw RecipeServiceError.invalidURL
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
        } catch {
            if error is DecodingError {
                throw RecipeServiceError.decodingError
            } else {
                throw RecipeServiceError.networkError(error)
            }
        }
    }
}
