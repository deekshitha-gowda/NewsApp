//
//  DarkModeManager.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI

class DarkModeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    func toggleDarkMode() {
        isDarkMode.toggle()
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}
