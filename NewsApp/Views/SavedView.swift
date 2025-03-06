//
//  SavedView.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//


import SwiftUI
import SDWebImageSwiftUI

import SwiftUI

struct SavedArticlesView: View {
    @StateObject var savedViewModel = SavedArticlesViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()

                if savedViewModel.savedArticles.isEmpty {
                    emptyStateView
                } else {
                    articlesListView
                }
            }
            .navigationTitle("Saved Articles")
            .onAppear { savedViewModel.refreshSavedArticles() }
        }
    }

    private var emptyStateView: some View {
        VStack {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("No saved articles")
                .font(.title3)
                .foregroundColor(.gray)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var articlesListView: some View {
        List {
            ForEach(savedViewModel.savedArticles, id: \.id) { article in
                SavedArticleCardView(article: article)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .onDelete(perform: deleteArticle)
        }
        .listStyle(PlainListStyle())
    }

    private func deleteArticle(at offsets: IndexSet) {
        offsets.forEach { savedViewModel.deleteArticle(savedViewModel.savedArticles[$0]) }
    }
}
