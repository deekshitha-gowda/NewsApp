//
//  SavedArticle + Extension.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import Foundation

extension SavedArticle {
    func toNewsArticle() -> NewsArticle {
        return NewsArticle(
            title: self.title ?? "",
            description: self.desc ?? "",
            urlToImage: self.imageUrl ?? "",
            url: self.url ?? "",
            publishedAt: formatDate(self.publishedAt)
        )
    }

    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "Unknown Date" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}
