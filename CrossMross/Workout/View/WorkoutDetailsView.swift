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
            VStack(alignment: .leading) {
                HStack {
                    Text(workout.type.rawValue)
                        .font(.title3)
                    Spacer()
                    Image(systemName: "stopwatch")
                    Text(WOD.formatTimeInterval(workout.getTotalDuration()))
                        .font(.title3)
                }
                .padding(.bottom, 3)
                .bold()
                Text(workout.getDisplayText())
                    .italic()
                VStack(alignment: .leading) {
                    // TODO: Belki type'a göre bir icon olabilir
                    ForEach(workout.movements, id: \.name) { movement in
                        Text(movement.getDisplayText())
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    WorkoutDetailsView(workout: Workout.mockWorkout())
}
