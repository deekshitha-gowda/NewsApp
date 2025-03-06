//
//  SavedArticleCardView.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SavedArticleCardView: View {
    let article: SavedArticle
    
    var body: some View {
        HStack(spacing: 12) {
            cachedImageView
            
            VStack(alignment: .leading, spacing: 6) {
                articleDetailsView
                
                Spacer()
                
                readMoreButton
            }
            
            Spacer()
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
        .transition(.opacity.combined(with: .move(edge: .trailing)))
        .animation(.easeInOut(duration: 0.3))
    }
    
    private var cachedImageView: some View {
        WebImage(url: URL(string: article.imageUrl ?? ""))
            .resizable()
            .placeholder {
                placeholderImage
                    .opacity(0.5)
                    .animation(.easeInOut(duration: 0.3))
            }
            .indicator(.activity)
            .scaledToFill()
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.leading, 5)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3))
    }
    
    private var placeholderImage: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 80, height: 80)
            .overlay(
                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundColor(.gray)
            )
    }
    
    private var articleDetailsView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(article.title ?? "")
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(article.desc ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.3))
    }
    
    private var readMoreButton: some View {
        HStack {
            Spacer()
            NavigationLink(destination: ArticleDetailView(article: article.toNewsArticle(), savedViewModel: SavedArticlesViewModel())) {
                Text("Read More →")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .opacity(0.9)
                    .animation(.easeInOut(duration: 0.2))
            }
        }
    }
}
