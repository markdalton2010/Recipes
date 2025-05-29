//
//  Untitled.swift
//  Recipes
//
//  Created by Mark Dalton on 5/29/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            guard let urlString = recipe.photo_url_small,
                  let url = URL(string: urlString)
            else { return }
            
            Task { try await imageLoader.load(from: url) }
        }
    }
}
