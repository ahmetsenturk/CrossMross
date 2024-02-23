//
//  WODTimer.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 23.02.24.
//

import SwiftUI

struct WODTimer: View {
    var body: some View {
        NavigationStack {
            Text("Select the timer you want to start :)")
                .font(.title2)
                .padding()
            ForEach(WorkoutType.allCases, id: \.self) { workoutType in
                NavigationLink(destination: destinationView(for: workoutType)) {
                    TimerCardView(color: .green, name: workoutType.rawValue)
                }
                .foregroundStyle(.primary)
            }
        }
    }
}

@ViewBuilder
private func destinationView(for workoutType: WorkoutType) -> some View {
    switch workoutType {
    case .AMRAP:
        AMRAPTimer()
    case .EMOM:
        EMOMTimer()
    case .FORTIME:
        AMRAPTimer() // TODO: Fix
    case .TABATA:
        AMRAPTimer() // TODO: Fix
    }
}

struct TimerCardView: View {
    var color: Color
    var name: String
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(name)
                        .font(.title3)
                        .bold()
                }
                .padding(.bottom, 0.5)
                .frame(width: 120)
            }
            .padding()
            .background(color)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct AMRAPTimer: View {
    var body: some View {
        Text("As many rounds as possible in:")
            .font(.title2)
        TimerView()
            .navigationTitle("AMRAP")
    }
}

struct EMOMTimer: View {
    var body: some View {
        Text("EMOM")
            .font(.title)
            .bold()
        Text("Every minute on a minute:")
            .font(.title2)
        TimerView()
            .navigationTitle("EMOM")
        // TODO: Burayı ayarlayalım - daha farklı bir logic olucak
    }
}


#Preview {
    WODTimer()
}
