//
//  NewsCardView.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsCardView: View {
    let article: NewsArticle
    @Binding var selectedCategory: String
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        HStack(spacing: 12) {
            WebImage(url: URL(string: article.urlToImage ?? ""))
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.title2)
                                .foregroundColor(.gray)
                        )
                }
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.leading, 5)

            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)

                Text(article.description ?? "No description available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()

                HStack {
                    Spacer()
                    NavigationLink(destination: ArticleDetailView(article: article, selectedCategory: selectedCategory, viewModel: viewModel, savedViewModel: SavedArticlesViewModel())) {
                        Text("Read More →")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .frame(height: 120)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
