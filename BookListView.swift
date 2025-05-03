//
//  BookListView.swift
//  book
//
//  Created by Horizon on 03/05/25.
//

import Foundation
import SwiftUI
struct BookListView: View {
    @StateObject private var viewModel = BookListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                HStack {
                    TextField("Search books...", text: $viewModel.searchQuery)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    Button(action: {
                        Task {
                            await viewModel.fetchBooks()
                        }
                    }) {
                        Text("Search")
                            .padding(.horizontal)
                    }
                    .padding(.trailing)
                }
                .padding(.top)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if viewModel.books.isEmpty {
                    VStack {
                        Text("No books found")
                            .padding()
                        
                        Button("Search for books") {
                            Task {
                                await viewModel.fetchBooks()
                            }
                        }
                        .padding()
                    }
                    .onAppear {
                        Task {
                            await viewModel.fetchBooks()
                        }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.books) { book in
                                NavigationLink(destination: BookDetailView(book: book)) {
                                    BookRow(book: book)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Open Library Books")
        }
    }
}

