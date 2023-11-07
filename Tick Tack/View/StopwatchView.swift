//
//  StopwatchView.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 05/11/2023.
//

import SwiftUI

struct StopwatchView: View {
    @State var startDate = Date.now
    @State var timeElapsed: Int = 0
    
    // 1
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        NavigationStack {
            Text("Time elapsed: \(timeElapsed) sec")
                .onReceive(timer) { firedDate in
                    print("timer fired")
                    timeElapsed = Int(firedDate.timeIntervalSince(startDate))
                }
            Button("Pause") {
                timer.upstream.connect().cancel()
            }
            Button("Resume") {
                // 2
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

            }
            Button("Reset") {
                // 2
                timeElapsed = 0
                startDate = Date.now

            }
        }
        .font(.largeTitle)
        .padding()
    }
}

#Preview {
    StopwatchView()
}