//
//  Article.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//
import Foundation

// MARK: -  News Model
struct NewsResponse: Codable {
    let articles: [NewsArticle]
}

struct NewsArticle: Codable, Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String?
    let urlToImage: String?
    let url: String
    let publishedAt: String
}
