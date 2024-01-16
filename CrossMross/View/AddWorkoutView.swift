//
//  AddWorkoutView.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 06.01.24.
//

import Foundation
import SwiftUI
import Observation

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Bindable var viewModel: CreateWODViewModel
    @State private var editingMovement = false
    @State private var editedIndex = 0

    var body: some View {
        Form {
            TextField("Name", text: $viewModel.workoutName)
            Picker("Type", selection: $viewModel.selectedType) {
                Text(WorkoutType.AMRAP.rawValue).tag(WorkoutType.AMRAP)
                Text(WorkoutType.EMOM.rawValue).tag(WorkoutType.EMOM)
                Text(WorkoutType.TABATA.rawValue).tag(WorkoutType.TABATA)
            }

            switch viewModel.selectedType {
            case .AMRAP:
                // TODO: Use Stepper for the duration instead. And get make two fields, one for hour and one for minutes
                TextField("Duration", value: $viewModel.workoutDuration, format: .number)
                    .keyboardType(.numberPad)
            case .EMOM:
                TextField("Every Duration", value: $viewModel.everyDuration, format: .number)
                    .keyboardType(.numberPad)
                TextField("For Duration", value: $viewModel.forDuration, format: .number)
                    .keyboardType(.numberPad)
            case .TABATA:
                TextField("Rounds", value: $viewModel.rounds, format: .number)
                TextField("Work Duration", value: $viewModel.workDuration, format: .number)
                TextField("Rest Duration", value: $viewModel.restDuration, format: .number)
            case .FORTIME:
                TextField("Duration", value: $viewModel.workoutDuration, format: .number)
                // TODO: Eğer bu seçildiyse aşağıda seçeceği movementlar için rep girmek zorunlu olmalı
            }
            
            Section(header: Text("Movements")) {
                if (editingMovement) {
                    MovementDetailView(viewModel: viewModel) {
                        // Closure to handle when the details are saved
                        addOrUpdateMovement(editedIndex)
                        self.editingMovement = false
                    }
                } else {
                    Group {
                        ForEach(viewModel.movements.indices, id: \.self) { index in
                            TextField("Movement \(index + 1)", text: $viewModel.movements[index].name)
                                .onTapGesture {
                                    editingMovement = true
                                    editedIndex = index
                                }
                        }
                        .onDelete(perform: deleteMovement)
                        Button(action: {
                            viewModel.movements.append(Movement(name: "")) // Add a new movement
                        }) {
                            Text("Add Movement")
                        }
                    }
                }
            }

            Button("Add Workout") {
                addWorkout()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func addOrUpdateMovement(_ index: Int) {
        // Assing the captured the values to the respected movement in the list
        viewModel.movements[index].name = viewModel.movementName
        viewModel.movements[index].duration = viewModel.movementDuration
        
        // Reset the viewModel's properties
        viewModel.movementName = ""
        viewModel.movementDuration = nil
    }

    private func addWorkout() {
        let newWorkout: Workout
        switch viewModel.selectedType {
        case .AMRAP:
            newWorkout = AMRAP(name: viewModel.workoutName, type: viewModel.selectedType, duration: viewModel.workoutDuration ?? 0, movements: viewModel.movements)
        case .EMOM:
            newWorkout = EMOM(name: viewModel.workoutName, type: viewModel.selectedType, everyDuration: viewModel.everyDuration ?? 0, forDuration: viewModel.forDuration ?? 0, movements: viewModel.movements)
        case .TABATA:
            newWorkout = TABATA(name: viewModel.workoutName, type: viewModel.selectedType, rounds: viewModel.rounds ?? 0, workDuration: viewModel.workDuration ?? 0, restDuration: viewModel.restDuration ?? 0, movements: viewModel.movements)
        case .FORTIME:
            newWorkout = FORTIME(name: viewModel.workoutName, type: viewModel.selectedType, duration: viewModel.workoutDuration ?? 0, movements: viewModel.movements)
        }
        viewModel.workouts.append(newWorkout)
    }
    
    private func deleteMovement(at offsets: IndexSet) {
        viewModel.movements.remove(atOffsets: offsets)
    }
}


struct MovementDetailView: View {
    @Bindable var viewModel: CreateWODViewModel
    var onSave: () -> Void

    var body: some View {
        TextField("Name", text: $viewModel.movementName)
        // ... other fields for reps, weight, distance, etc. ...
        Button("Save Movement Details", action: onSave)
    }
}

#Preview {
    AddWorkoutView(viewModel: CreateWODViewModel())
}
