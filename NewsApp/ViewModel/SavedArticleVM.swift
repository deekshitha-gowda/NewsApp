//
//  SavedArticleVM.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI

class SavedArticlesViewModel: ObservableObject {
    @Published var savedArticles: [SavedArticle] = []

    init() {
        refreshSavedArticles()
    }

    func refreshSavedArticles() {
        DispatchQueue.main.async {
            self.savedArticles = CoreDataManager.shared.fetchSavedArticles()
        }
    }

    func deleteArticle(_ article: SavedArticle) {
        CoreDataManager.shared.deleteArticle(article.toNewsArticle())
        refreshSavedArticles()
    }

    func isSaved(article: NewsArticle) -> Bool {
        return savedArticles.contains { $0.url == article.url }
    }

    func toggleSave(article: NewsArticle) {
        if let existingArticle = savedArticles.first(where: { $0.url == article.url }) {
            CoreDataManager.shared.deleteArticle(existingArticle.toNewsArticle())
        } else {
            CoreDataManager.shared.saveArticle(article)
        }
        refreshSavedArticles()
    }
}
