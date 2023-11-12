//
//  TimerView.swift
//  Tick Tack
//
//  Created by Pedro Cordeiro on 07/11/2023.
//

import SwiftUI
import Foundation

struct TimerView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 350

    var body: some View {
        VStack {
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .alert("Timer done!", isPresented: $vm.showingAlert) {

                    Button("Continue", role: .cancel) {
                        // Code
                    }
                }
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 4)
                )
            
            Slider(value: $vm.minutes, in: 0...60, step: 1)
                .padding()
                .disabled(vm.isActive)
                .animation(.easeInOut, value: vm.minutes)
                .frame(width: width+100)
            
            HStack(spacing:10) {
                Button(vm.timerStarted ? "Resume" : "Start") {
                    vm.timerStarted ? vm.isActive = true : vm.start(minutes: vm.minutes)
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.isActive)
                Button("Pause") {
                    vm.isActive = false
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.isActive == false)
                Button("Reset") {
                    vm.reset()
                }
                .disabled(vm.isActive)
                .buttonStyle(.borderedProminent)
            }
            .frame(width: width)
        }
        .padding()
        .onReceive(timer) { _ in
            vm.updateCountdown()
        }
    }
}

extension TimerView {
    final class ViewModel: ObservableObject {
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "5:00"
        @Published var timerStarted = false
        @Published var minutes: Float = 5.00 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        var initialTime = 0
        var endDate = Date()
        
        // Start the timer with the given amount of minutes
        func start(minutes: Float) {
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
            self.timerStarted = true // Set the timerStarted property to true
        }
        
        // Reset the timer
        func reset() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
            self.timerStarted = false
        }
        
        // Show updates of the timer
        func updateCountdown(){
            guard isActive else { return }
            
            // Gets the current date and makes the time difference calculation
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            // Checks that the countdown is not <= 0
            if diff <= 0 {
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true
                return
            }
            
            // Turns the time difference calculation into sensible data and formats it
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)

            // Updates the time string with the formatted time
            self.minutes = Float(minutes)
            self.time = String(format:"%d:%02d", minutes, seconds)
        }
    }
}

#Preview {
    TimerView()
}
