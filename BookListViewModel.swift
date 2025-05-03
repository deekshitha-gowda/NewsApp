//
//  BookListViewModel.swift
//  book
//
//  Created by Horizon on 03/05/25.
//

import Foundation
class BookListViewModel: ObservableObject {
    @Published var books: [Doc] = []
    @Published var isLoading = false
    @Published var searchQuery = "movie"
    
    func fetchBooks() async {
        guard let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://openlibrary.org/search.json?q=\(encodedQuery)&limit=50") else { return }

    
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(SearchResponse.self, from: data)
            
            await MainActor.run {
                self.books = response.docs
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}

