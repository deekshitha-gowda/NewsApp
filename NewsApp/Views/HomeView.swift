//
//  HomeView.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var selectedCategory = "All"
    @State private var isLoading = true
    @State private var isOnline = NetworkMonitor.shared.isConnected
    @StateObject var darkModeManager = DarkModeManager()

    let categories = ["All", "Business", "Sports", "Technology", "Entertainment", "Health", "Science"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    categorySelector
                    Divider()
                }
                
                newsList
            }
            .navigationTitle("News")
            .toolbar { toolbarItems }
            .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
            .onAppear { loadInitialData() }
            .onReceive(NetworkMonitor.shared.$isConnected) { newStatus in
                isOnline = newStatus
                if newStatus { viewModel.fetchNews(for: selectedCategory) }
            }
        }
    }

    private var categorySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        if selectedCategory != category {
                            withAnimation {
                                isLoading = true
                                selectedCategory = category
                            }
                            viewModel.fetchNews(for: category) {
                                withAnimation { isLoading = false }
                            }
                        }
                    }) {
                        Text(category)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
        .padding(.top, 8)
    }

    private var newsList: some View {
        ZStack {
            if isLoading {
                ProgressView("Loading News...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                List(viewModel.articles) { article in
                    NewsCardView(article: article, selectedCategory: $selectedCategory, viewModel: viewModel)
                        .contentShape(Rectangle())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                .listStyle(PlainListStyle())
            }
        }
    }

    private var toolbarItems: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            HStack(spacing: 6) {
                Image(systemName: isOnline ? "circle.fill" : "exclamationmark.triangle.fill")
                    .foregroundColor(isOnline ? .green : .orange)
                Text(isOnline ? "Online" : "Offline")
                    .foregroundColor(isOnline ? .green : .orange)
            }
            Button(action: { darkModeManager.toggleDarkMode() }) {
                Image(systemName: darkModeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                    .foregroundColor(darkModeManager.isDarkMode ? .yellow : .gray)
            }
        }
    }

    private func loadInitialData() {
        if viewModel.articles.isEmpty {
            viewModel.fetchNews(for: selectedCategory) { isLoading = false }
        }
    }
}
