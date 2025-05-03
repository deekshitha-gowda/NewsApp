//
//  Model.swift
//  book
//
//  Created by Horizon on 03/05/25.
//

import Foundation
import SwiftUI
struct SearchResponse: Codable {
    let numFound: Int
    let start: Int
    let numFoundExact: Bool
    let numFoundKey: Int
    let documentationURL: String
    let query: String
    let offset: String?
    let docs: [Doc]
    
    enum CodingKeys: String, CodingKey {
        case numFound = "numFound"
        case start
        case numFoundExact
        case numFoundKey = "num_found"
        case documentationURL = "documentation_url"
        case query = "q"
        case offset
        case docs
    }
}

struct Doc: Codable, Identifiable {
    let id = UUID()
    let authorKey: [String]?
    let authorName: [String]?
    let coverEditionKey: String?
    let coverI: Int?
    let editionCount: Int?
    let firstPublishYear: Int?
    let hasFulltext: Bool?
    let ia: [String]?
    let iaCollection: String?
    let key: String?
    let language: [String]?
    let lendingEdition: String?
    let lendingIdentifier: String?
    let publicScan: Bool?
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case authorKey = "author_key"
        case authorName = "author_name"
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case ia
        case iaCollection = "ia_collection_s"
        case key
        case language
        case lendingEdition = "lending_edition_s"
        case lendingIdentifier = "lending_identifier_s"
        case publicScan = "public_scan_b"
        case title
    }

    func coverImageURL(size: String = "M") -> URL? {
        guard let coverId = self.coverI else {
            return nil
        }
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-\(size).jpg")
    }
    
    func coverEditionURL(size: String = "M") -> URL? {
        guard let editionKey = self.coverEditionKey else {
            return nil
        }
        return URL(string: "https://covers.openlibrary.org/b/olid/\(editionKey)-\(size).jpg")
    }
}
