//
//  BookDetailView.swift
//  book
//
//  Created by Horizon on 03/05/25.
//


import SwiftUI
import CoreData
import Foundation


struct BookDetailView: View {
    let book: Doc
    @StateObject private var viewModel = BookmarkViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    AsyncImage(url: book.coverImageURL(size: "L") ?? book.coverEditionURL(size: "L")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .shadow(radius: 5)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 200, height: 300)
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
                
                Text(book.title)
                    .font(.largeTitle)
                    .bold()
                
                Text("Author: \(book.authorName?.joined(separator: ", ") ?? "Unknown")")
                    .font(.title2)
                    .padding(.top, 4)
                
                if let year = book.firstPublishYear {
                    Text("First Published: \(year)")
                        .padding(.top, 2)
                }
                
                if let editions = book.editionCount {
                    Text("Editions: \(editions)")
                        .padding(.top, 2)
                }
                
                if let languages = book.language, !languages.isEmpty {
                    Text("Languages: \(languages.joined(separator: ", "))")
                        .padding(.top, 2)
                }
                
                
                
                Spacer()
            }
            .padding()
        }.onAppear {
            viewModel.checkIfBookmarked(doc: book)
        }
        .navigationTitle(book.title ?? "Untitled")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleBookmark(doc: book)
                    print("")
                }) {
                    Image(systemName:  viewModel.isBookmarked ? "bookmark.fill" : "bookmark")
                }
            }
        }

    }
}
//Image(systemName: book.isBookmarked ? "bookmark.fill" : "bookmark")


struct ContentViews: View {
    var body: some View {
        BookListView()
    }
}

