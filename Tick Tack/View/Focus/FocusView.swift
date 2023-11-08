//
//  FocusView.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 05/11/2023.
//

import SwiftUI

public extension Color {

    #if os(macOS)
    static let backgroundColor2 = Color(NSColor.windowBackgroundColor)
    static let secondaryBackgroundColor2 = Color(NSColor.controlBackgroundColor)
    #else
    static let backgroundColor = Color(UIColor.systemBackground)
    static let secondaryBackgroundColor = Color(UIColor.secondarySystemBackground)
    #endif
}

public struct FocusTabView: View {
    
    public enum TabBarPosition { // Where the tab bar will be located within the view
        case top
        case bottom
    }
    
    private let tabBarPosition: TabBarPosition
    private let tabText: [String]
    private let tabIconName: [String]
    private let tabViews: [AnyView]
    
    @State private var selection = 0
    
    public init(tabBarPosition: TabBarPosition, content: [(tabText: String, tabIconName: String, view: AnyView)]) {
        self.tabBarPosition = tabBarPosition
        self.tabText = content.map{ $0.tabText }
        self.tabIconName = content.map{ $0.tabIconName }
        self.tabViews = content.map{ $0.view }
    }
    
    public var tabBar: some View {
        
        HStack {
            Spacer()
            ForEach(0..<tabText.count) { index in
                HStack {
                    Image(systemName: "\(self.tabIconName[index])")
                    Text(self.tabText[index])
                }.fontWeight(.semibold)
                .padding()
                .foregroundColor(self.selection == index ? Color.accentColor : Color.primary)
                .background(Color.secondaryBackgroundColor)
                .onTapGesture {
                    self.selection = index
                }
            }
            Spacer()
        }
        .padding(0)
        .background(Color.secondaryBackgroundColor) // Extra background layer to reset the shadow and stop it applying to every sub-view
        .shadow(color: Color.clear, radius: 0, x: 0, y: 0)
        .background(Color.secondaryBackgroundColor)
        .shadow(
            color: Color.black.opacity(0.25),
            radius: 3,
            x: 0,
            y: tabBarPosition == .top ? 1 : -1
        )
        .zIndex(99) // Raised so that shadow is visible above view backgrounds
    }
    public var body: some View {
        
        VStack(spacing: 0) {
            
            if (self.tabBarPosition == .top) {
                tabBar
            }
            
            tabViews[selection]
                .padding(0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if (self.tabBarPosition == .bottom) {
                tabBar
            }
        }
        .padding(0)
    }
}

struct FocusView: View {
    
    var body: some View {
        NavigationStack {
            CustomTabView(
                tabBarPosition: .top,
                content: [
                    (
                        tabText: "Focus",
                        tabIconName: "timer",
                        view: AnyView(
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    PomodoroView()
                                    Spacer()
                                }
                                Spacer()
                            }
                        )
                    ),
                    (
                        tabText: "Break",
                        tabIconName: "pause.fill",
                        view: AnyView(
                            HStack {
                                Spacer()
                                BreakView()
                                Spacer()
                            }
                        )
                    ),
                ]
            )
            .padding(-8)
        }
    }
}

#Preview {
    FocusView()
}
