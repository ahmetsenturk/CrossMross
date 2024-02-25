//
//  CreateWODView.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 25.12.23.
//

import Foundation
import SwiftUI

struct CreateWODView: View {
    @State private var viewModel = CreateWODViewModel()
    @State private var showAddWorkout = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("WOD Details") {
                    TextField("Name", text: $viewModel.WODname)
                    Picker("Type", selection: $viewModel.type) {
                        Text(WODType.ENDURANCE.rawValue).tag(WODType.ENDURANCE)
                        Text(WODType.OLYLIFTING.rawValue).tag(WODType.OLYLIFTING)
                        Text(WODType.STRENGTH.rawValue).tag(WODType.STRENGTH)
                    }
                }
                Section(header: HStack {
                    Text("Workouts")
                    Spacer()
                    Button(action: {
                        showAddWorkout = true
                    }) {
                        Image(systemName: "plus")
                    }
                }) {
                    ForEach(viewModel.workouts, id: \.name) { workout in
                        HStack {
                            Text(workout.name)
                            Text(workout.type.rawValue)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddWorkout) {
                AddWorkoutView(viewModel: viewModel)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // TODO: Save and close
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    CreateWODView()
}

