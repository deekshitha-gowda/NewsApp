//
//  BookListViewModelTests.swift..swift
//  bookTests
//
//  Created by Horizon on 03/05/25.
//
import Foundation
import XCTest
@testable import book

final class BookListViewModelTests: XCTestCase {
    var viewModel: BookListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = BookListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    

    func testFetchBooksReturnsData() async {
        viewModel.searchQuery = "harry potter"
        await viewModel.fetchBooks()

        await MainActor.run {
            XCTAssertFalse(viewModel.books.isEmpty, "Books should not be empty after fetch")

            let hasHarryInAnyTitle = viewModel.books.contains { book in
                book.title.lowercased().contains("harry")
            }
            XCTAssertTrue(hasHarryInAnyTitle, "Expected at least one title containing 'harry'")
        }
    }

    func testSearchQueryEncoding() {
        viewModel.searchQuery = "swift programming"
        let encoded = viewModel.searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        XCTAssertEqual(encoded, "swift%20programming")
    }
}
