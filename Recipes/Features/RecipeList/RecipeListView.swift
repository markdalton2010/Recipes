//
//  RecipeListView.swift
//  Recipes
//
//  Created by Mark Dalton on 5/29/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    @State private var taskId = UUID()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            taskId = UUID()
                        }
                    }
                } else if viewModel.recipes.isEmpty {
                    Text("No recipes available.")
                        .foregroundColor(.secondary)
                } else {
                    List(viewModel.recipes) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        taskId = UUID()
                    }
                }
            }
            .navigationTitle("Recipes")
        }
        .task(id: taskId) {
            await viewModel.getRecipes()
        }
    }
}

#Preview {
    RecipeListView()
}
