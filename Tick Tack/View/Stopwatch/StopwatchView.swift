//
//  StopwatchView.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 05/11/2023.
//

import SwiftUI

struct StopwatchView: View {
    
    @ObservedObject var stopWatchManager = StopwatchManager()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            Text(String(format: "%.1f", stopWatchManager.secondsElapsed))
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 4)
                    )
            Divider()
                .frame(width: 0)
                .padding(1)
            HStack(spacing: 10) {
                if stopWatchManager.mode == .paused {
                    Button(action: {self.stopWatchManager.start()}) {
                        Text("Resume")
                    }.disabled(stopWatchManager.mode == .running).buttonStyle(.borderedProminent)
                } else {
                    Button(action: {self.stopWatchManager.start()}) {
                        Text("Start")
                    }
                    .disabled(stopWatchManager.mode == .running)
                    .buttonStyle(.borderedProminent)
                }
                if stopWatchManager.mode == .paused {
                    Button(action: {self.stopWatchManager.stop()}) {
                        Text("Stop")
                    }
                    .disabled(stopWatchManager.mode == .stopped)
                    .buttonStyle(.borderedProminent)
                } else if stopWatchManager.mode == .running {
                    Button(action: {self.stopWatchManager.pause()}) {
                        Text("Stop")
                    }
                    .disabled(stopWatchManager.mode == .stopped)
                    .disabled(stopWatchManager.mode == .paused)
                    .buttonStyle(.borderedProminent)
                } else if stopWatchManager.mode == .stopped {
                    Button(action: {self.stopWatchManager.stop()}) {
                        Text("Reset")
                    }.disabled(true)
                }
            }
        }.padding()
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    StopwatchView()
}
