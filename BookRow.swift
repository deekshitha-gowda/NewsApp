//
//  BookRow.swift
//  book
//
//  Created by Horizon on 03/05/25.
//

import Foundation
import SwiftUI
struct BookRow: View {
    let book: Doc
    
    var body: some View {
        HStack {
            AsyncImage(url: book.coverImageURL() ?? book.coverEditionURL()) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 80)
              
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 80)
            }
            .cornerRadius(4)
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(book.authorName?.first ?? "Unknown")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
    }
}
