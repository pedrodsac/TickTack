//
//  AboutView.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 05/11/2023.
//

import SwiftUI
import Swift

struct AboutView: View {
    var body: some View {
        NavigationStack {
            HStack {
                Image("Icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("Tick Tack")
                        .font(.title)
                        .bold()
                    Text("A Pomodoro/Focus Timer")
                        .font(.body)
                    Text("v1.0")
                        .font(.caption)
                        .padding(.top, 1)
                }.padding()
            }.padding()
        }
    }
}

#Preview {
    AboutView()
}
