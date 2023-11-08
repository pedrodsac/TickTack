//
//  StopwatchManager.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 08/11/2023.
//

import Foundation
import SwiftUI
 
class StopwatchManager: ObservableObject {
     
    enum stopWatchMode {
        case running
        case stopped
        case paused
    }
     
    @Published var mode: stopWatchMode = .stopped
     
    @Published var secondsElapsed = 0.0
    var timer = Timer()
     
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.secondsElapsed += 0.1
        }
    }
     
    func pause() {
        timer.invalidate()
        mode = .paused
    }
     
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
}

