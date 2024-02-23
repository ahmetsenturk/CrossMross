//
//  Timer.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 23.02.24.
//

import SwiftUI

struct TimePicker: View {
    @Binding var selectedHours: Int
    @Binding var selectedMinutes: Int
    @Binding var selectedSeconds: Int
    
    let hours = Array(0...23)
    let minutesAndSeconds = Array(0...59)
    
    var body: some View {
        HStack {
            Picker("Hours", selection: $selectedHours) {
                ForEach(hours, id: \.self) {
                    Text("\($0) hours")
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Minutes", selection: $selectedMinutes) {
                ForEach(minutesAndSeconds, id: \.self) {
                    Text("\($0) min")
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Seconds", selection: $selectedSeconds) {
                ForEach(minutesAndSeconds, id: \.self) {
                    Text("\($0) sec")
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        .frame(height: 150)
    }
}

struct CountdownView: View {
    @Binding var animationProgress: CGFloat
    var timerModel: TimerModel
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: animationProgress)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.orange)
                .rotationEffect(Angle(degrees: -90))
            
            VStack {
                Text(timerModel.formattedTime)
                    .font(.title)
                Text("Tap to \(timerModel.timerRunning ? "pause" : "continue")")
                    .foregroundStyle(.gray)
            }
            
        }
        .frame(width: 200, height: 200)
        .onTapGesture {
            switch timerModel.timerStatus {
            case .PAUSE:
                timerModel.pauseTimer()
                withAnimation {
                    animationProgress = timerModel.remainingProgress()
                }
            case .CONTINUE:
                timerModel.continueTimer()
                withAnimation(.linear(duration: Double(timerModel.timeRemaining))) {
                    self.animationProgress = 0.0
                }
            case .START:
                // TODO: Fix here
                timerModel.continueTimer()
            }
        }
    }
}

struct TimerView: View {
    private var timerModel = TimerModel()
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var selectedSeconds = 0
    @State private var totalTime: Int = 0 // Keep track of the total time set for the timer
    @State private var animationProgress: CGFloat = 1.0


    let hours = Array(0...23)
    let minutesAndSeconds = Array(0...59)
    
    var body: some View {
        VStack {
            if (timerModel.timerStatus == TimerStatus.START) {
                TimePicker(selectedHours: $selectedHours, selectedMinutes: $selectedMinutes, selectedSeconds: $selectedSeconds)
            } else {
                CountdownView(animationProgress: $animationProgress, timerModel: timerModel)
            }
            
            HStack {
                Button("Cancel") {
                    timerModel.stopTimer()
                    timerModel.totalTime = totalTime
                    timerModel.setTime(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
                    withAnimation {
                        self.animationProgress = 1.0
                    }
                }
                Spacer()
                Button(timerModel.timerStatus.rawValue) {
                    switch timerModel.timerStatus {
                    case .PAUSE:
                        timerModel.pauseTimer()
                        withAnimation {
                            self.animationProgress = timerModel.remainingProgress()
                        }
                    case .START:
                        totalTime = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
                        timerModel.totalTime = totalTime
                        timerModel.setTime(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
                        timerModel.startTimer()
                        withAnimation(.linear(duration: Double(totalTime))) {
                            self.animationProgress = 0.0
                        }
                    case .CONTINUE:
                        timerModel.continueTimer()
                        withAnimation(.linear(duration: Double(totalTime))) {
                            self.animationProgress = 0.0
                        }
                    }
                }
                .padding()
                .foregroundColor(timerModel.timerRunning ? Color.red : Color.green)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    TimerView()
}

