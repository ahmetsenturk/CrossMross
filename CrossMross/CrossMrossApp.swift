//
//  CrossMrossApp.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 22.12.23.
//

import SwiftUI

@main
struct CrossMrossApp: App {
    @State private var wods = WOD.mockWODs()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                WODListView(wods: $wods)
                    .tabItem {
                        Label("WODs", systemImage: "figure.strengthtraining.traditional")
                    }
                CreateWODView()
                    .tabItem {
                        Label("Create WOD", systemImage: "square.and.pencil")
                    }
                MaxRecordsTable()
                    .tabItem {
                        Label("PRs", systemImage: "square.and.pencil")
                    }
            }
        }
    }
}
