//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI

@main
struct NewsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
