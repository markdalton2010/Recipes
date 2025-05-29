//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Mark Dalton on 5/29/25.
//

import XCTest
@testable import Recipes

class RecipeServiceTests: XCTestCase {
    let testImageUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
    
    func testGetRecipes() async throws {
        let service = RecipeService(endpoint: .normal)
        let recipes = try await service.getRecipes()
        XCTAssertFalse(recipes.isEmpty, "Recipes were empty.")
    }
    
    func testMalformedData() async throws {
        let service = RecipeService(endpoint: .malformed)
        do {
            _ = try await service.getRecipes()
        } catch let error as RecipeServiceError {
            guard case .decodingError = error else {
                XCTFail("Failure was not from decoding error.")
                return
            }
        }
    }
    
    func testEmptyData() async throws {
        let service = RecipeService(endpoint: .empty)
        let recipes = try await service.getRecipes()
        XCTAssert(recipes.isEmpty, "Recipes were not empty.")
    }
    
    @MainActor
    func testLoadImageFromNetwork() async throws {
        guard let url = testImageUrl else {
            XCTFail("Invalid URL")
            return
        }
        let loader = ImageLoader()
        try await loader.load(from: url)
        XCTAssertNotNil(loader.image)
    }
    
    @MainActor
    func testLoadImageFromCache() async throws {
        guard let url = testImageUrl else {
            XCTFail("Invalid URL")
            return
        }
        let loader = ImageLoader()
        try await loader.load(from: url)
        loader.image = nil
        XCTAssertNotNil(loader.loadFromCache(url))
    }
}
