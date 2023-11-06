//
//  SettingsView.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 06/11/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    ForEach(settingsTabs) { item in
                        NavigationLink {
                            item.destination
                        } label: {
                            Label {
                                Text(item.name)
                            } icon: {
                                Image(systemName: item.icon)
                            }

                        }
                        Spacer()
                    }
                }
                .padding()
                Spacer()
            }
            Spacer()
        }
    }
}

struct settingsTab: Identifiable {
    var id: String { name }
    var name: String
    var icon: String
    var destination: AnyView
}

var settingsTabs: [settingsTab] = [
    settingsTab(name: "About", icon: "info.circle", destination: AnyView(AboutView())),
]

#Preview {
    SettingsView()
}
