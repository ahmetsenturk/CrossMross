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
                        .font(.custom("Lemon Tuesday", size: 30, relativeTo: .title))
                    Spacer()
                    Image(systemName: "stopwatch")
                        .foregroundStyle(.orange)
                    Text(WOD.formatTimeInterval(workout.getTotalDuration()))
                        .font(.custom("Lemon Tuesday", size: 20, relativeTo: .title3))
                        .foregroundStyle(.orange)
                }
                .padding(.bottom, 3)
                .bold()
                Text(workout.getDisplayText())
                    .font(.custom("Lemon Tuesday", size: 20))
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
