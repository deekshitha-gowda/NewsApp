//
//  BookmarkVm.swift
//  book
//
//  Created by Horizon on 03/05/25.
//

import Foundation
import Foundation
import CoreData

class BookmarkViewModel: ObservableObject {
    private let context = PersistenceController.shared.container.viewContext
    @Published var isBookmarked: Bool = false

    func checkIfBookmarked(doc: Doc) {
        guard let key = doc.key else { return }
        let request: NSFetchRequest<BookMarkItem> = BookMarkItem.fetchRequest()
        request.predicate = NSPredicate(format: "key == %@", key)

        do {
            isBookmarked = try context.fetch(request).first != nil
        } catch {
            print("Failed to check bookmark: \(error)")
        }
    }

    func toggleBookmark(doc: Doc) {
        guard let key = doc.key else { return }
        if isBookmarked {
            removeBookmark(key: key)
        } else {
            addBookmark(doc: doc)
        }
    }

    private func addBookmark(doc: Doc) {
        guard let key = doc.key else { return }
        let item = BookMarkItem(context: context)
        item.key = key
        item.title = doc.title
        item.authorName = doc.authorName?.first ?? "Unknown"
        item.coverI = Int64(doc.coverI ?? 0)

        save()
        isBookmarked = true
    }

    private func removeBookmark(key: String) {
        let request: NSFetchRequest<BookMarkItem> = BookMarkItem.fetchRequest()
        request.predicate = NSPredicate(format: "key == %@", key)

        do {
            if let item = try context.fetch(request).first {
                context.delete(item)
                save()
                isBookmarked = false
            }
        } catch {
            print("Failed to remove bookmark: \(error)")
        }
    }

    private func save() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
