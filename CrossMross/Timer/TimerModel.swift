//
//  TimerModel.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 23.02.24.
//

import Foundation
import Observation

@Observable class TimerModel {
    var timeRemaining: Int = 0
    var timerRunning: Bool = false
    var totalTime: Int?
    var timer: Timer?
    var timerStatus = TimerStatus.START
    
    func startTimer() {
        timerRunning = true
        timerStatus = .PAUSE
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let strongSelf = self {
                if strongSelf.timeRemaining > 0 {
                    strongSelf.timeRemaining -= 1
                } else {
                    strongSelf.stopTimer()
                }
            }
        }
    }
    
    func remainingProgress() -> CGFloat {
        return CGFloat(Double(timeRemaining)/(Double(totalTime ?? 1)))
    }
    
    func stopTimer() {
        timerRunning = false
        timerStatus = .START
        timer?.invalidate()
        timer = nil
    }
    
    func pauseTimer() {
        timerRunning = false
        timerStatus = .CONTINUE
        timer?.invalidate()
        timer = nil
    }
    
    func setTime(hours: Int, minutes: Int, seconds: Int) {
        timeRemaining = hours * 3600 + minutes * 60 + seconds
    }
    
    func continueTimer() {
        if !timerRunning && timeRemaining > 0 {
            // Only continue the timer if it's not currently running and there's time remaining.
            startTimer() // Re-use startTimer method to resume counting down.
        }
    }
}

extension TimerModel {
    var formattedTime: String {
        let hours = timeRemaining / 3600
        let minutes = (timeRemaining % 3600) / 60
        let seconds = timeRemaining % 60
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    var progress: Float {
        guard let totalTime = totalTime else { return 1 }
        return totalTime > 0 ? Float(timeRemaining) / Float(totalTime) : 0
    }    
}

enum TimerStatus: String {
    case PAUSE = "Pause"
    case START = "Start"
    case CONTINUE = "Continue"
}
