//
//  WorkoutDetailsView.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 01.01.24.
//

import Foundation
import SwiftUI

struct WorkoutDetailsView: View {
    var workout: Workout
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(workout.name)
                        .font(.title3)
                    Text(workout.type.rawValue)
                        .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.purple)
                    Spacer()
                    Image(systemName: "stopwatch")
                    Text(WOD.formatTimeInterval(workout.getTotalDuration()))
                        .font(.title3)
                }
                .padding(.bottom, 0.5)
                .bold()
                VStack {
                    // TODO: Belki type'a göre bir icon olabilir
                    ForEach(workout.movements, id: \.name) { movement in
                        Text(movement.name)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                
            }
            .padding()
        }
    }
}

#Preview {
    WorkoutDetailsView(workout: Workout.mockWorkout())
}
