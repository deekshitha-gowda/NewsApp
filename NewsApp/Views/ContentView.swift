//
//  ContentView.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            SavedArticlesView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark.fill")
                }
        }
    }
}
