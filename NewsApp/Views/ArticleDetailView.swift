//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//


import SwiftUI
import WebKit

struct ArticleDetailView: View {
    let article: NewsArticle
    var selectedCategory: String?
    var viewModel: NewsViewModel?
    @ObservedObject var savedViewModel: SavedArticlesViewModel
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    @State private var isLoading = true
    @State private var loadFailed = false
    @State private var isSaved = false

    var body: some View {
        VStack(spacing: 0) {
            Text(article.title)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, 8)

            Divider()

            if networkMonitor.isConnected {
                if let validURL = URL(string: article.url ?? ""), UIApplication.shared.canOpenURL(validURL) {
                    ZStack {
                        WebView(url: validURL, isLoading: $isLoading, loadFailed: $loadFailed)
                            .opacity(isLoading ? 0 : 1)
                            .animation(.easeInOut(duration: 0.3), value: isLoading)

                        if isLoading {
                            ProgressView("Loading Article...")
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        }

                        if loadFailed {
                            VStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.orange)
                                Text("Failed to load article.")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                                    .padding()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        Text("This article cannot be loaded.")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } else {
                VStack {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    Text("No Internet Connection.")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Divider()

            HStack {
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        handleSaveToggle()
                    }
                }) {
                    Label(isSaved ? "Saved" : "Save", systemImage: isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isSaved ? .white : .blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(isSaved ? Color.blue : Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .scaleEffect(isSaved ? 1.1 : 1.0)
                }

                Spacer()

                Button(action: shareArticle) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
            .padding(.top, 16)
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            updateSaveStatus()
        }
    }

    func updateSaveStatus() {
        isSaved = savedViewModel.isSaved(article: article)
    }

    func handleSaveToggle() {
        savedViewModel.toggleSave(article: article)
        isSaved.toggle()
    }

    func shareArticle() {
        if let url = URL(string: article.urlToImage ?? "https://www.example.com") {
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true)
        }
    }
}
