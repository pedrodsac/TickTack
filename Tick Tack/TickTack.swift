//
//  Tick_TackApp.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 05/11/2023.
//

import SwiftUI

@main
struct TickTack: App {
    var body: some Scene {
        WindowGroup {
            ContentView()

        }
        Settings {
            SettingsView()
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                NavigationLink {
                    AboutView()
                        .fixedSize()
                } label: {
                    Text("About Tick Tack")
                }
            }
        }
        .windowResizability(.contentSize)
    }
}
