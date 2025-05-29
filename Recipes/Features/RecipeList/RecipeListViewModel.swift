//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Mark Dalton on 5/29/25.
//

import Foundation

@MainActor
final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = true
    @Published var errorMessage: String?

    func getRecipes() async {
        if recipes.isEmpty {
            isLoading = true
        }
        errorMessage = nil

        do {
            let fetched = try await RecipeService().getRecipes()
            recipes = fetched
        } catch {
            errorMessage = (error as? RecipeServiceError)?.errorDescription
        }

        isLoading = false
    }
}
