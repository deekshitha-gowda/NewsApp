//
//  bookApp.swift
//  book
//
//  Created by Horizon on 03/05/25.
//

import SwiftUI

@main
struct bookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BookListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

