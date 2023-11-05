//
//  ContentView.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 05/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TimerView()
                .tabItem { Text("Timer") }
            FocusView()
                .tabItem { Text("Focus") }
        }
    }
}

#Preview {
    ContentView()
}
