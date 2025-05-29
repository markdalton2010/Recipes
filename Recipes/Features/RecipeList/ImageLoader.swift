//
//  Untitled.swift
//  Recipes
//
//  Created by Mark Dalton on 5/29/25.
//

import UIKit

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func load(from url: URL) async throws {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        let fileName = url.absoluteString
            .addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
        let fileURL = cachesDirectory.appendingPathComponent(fileName)
        
        if loadFromCache(fileURL) {
            return
        }

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let downloadedImage = UIImage(data: data) else {
            return
        }

        self.image = downloadedImage
        try data.write(to: fileURL)
    }
    
    func loadFromCache(_ fileURL: URL) -> Bool {
        guard let data = try? Data(contentsOf: fileURL),
              let cachedImage = UIImage(data: data)
        else {
            return false
        }
        self.image = cachedImage
        return true
    }
}
