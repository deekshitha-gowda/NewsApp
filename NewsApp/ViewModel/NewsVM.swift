//
//  NewsVM.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import Foundation
import Combine
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []

    private let coreDataManager = CoreDataManager.shared

    func fetchNews(for category: String, completion: (() -> Void)? = nil) {
        if NetworkMonitor.shared.isConnected {
            NetworkManager.shared.fetchNews(for: category) { result in
                switch result {
                case .success(let newsArticles):
                    DispatchQueue.main.async {
                        self.articles = newsArticles
                        self.coreDataManager.cacheNews(newsArticles)
                        completion?()
                    }
                case .failure(let error):
                    print("Error fetching news: \(error.localizedDescription)")
                }
            }
        } else {
            self.articles = coreDataManager.fetchCachedNews()
            completion?()
        }
    }
}
