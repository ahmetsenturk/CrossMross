//
//  CreateWODViewModel.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 06.01.24.
//

import Foundation
import Observation

@Observable class CreateWODViewModel {
    // WOD properties
    var WODname: String = ""
    var type: WODType = .ENDURANCE
    var workouts: [Workout] = []
    
    // Workout properties
    var workoutName: String = ""
    var selectedType: WorkoutType = .AMRAP
    var workoutDuration: TimeInterval? // For AMRAP
    var everyDuration: TimeInterval? // For EMOM
    var forDuration: TimeInterval? // For EMOM
    var rounds: Int? // For TABATA
    var workDuration: TimeInterval? // For TABATA
    var restDuration: TimeInterval? // For TABATA
    var movements: [Movement] = []
    
    // Movement properties
    var movementName: String = ""
    var reps: Int?
    var weight: Double?
    var distance: Double?
    var movementDuration: TimeInterval?
    var equipment: String?
    
    init(WODname: String, type: WODType, workouts: [Workout], workoutName: String, selectedType: WorkoutType, workoutDuration: TimeInterval? = nil, everyDuration: TimeInterval? = nil, forDuration: TimeInterval? = nil, rounds: Int? = nil, workDuration: TimeInterval? = nil, restDuration: TimeInterval? = nil, movements: [Movement], movementName: String, reps: Int? = nil, weight: Double? = nil, distance: Double? = nil, movementDuration: TimeInterval? = nil, equipment: String? = nil) {
        self.WODname = WODname
        self.type = type
        self.workouts = workouts
        self.workoutName = workoutName
        self.selectedType = selectedType
        self.workoutDuration = workoutDuration
        self.everyDuration = everyDuration
        self.forDuration = forDuration
        self.rounds = rounds
        self.workDuration = workDuration
        self.restDuration = restDuration
        self.movements = movements
        self.movementName = movementName
        self.reps = reps
        self.weight = weight
        self.distance = distance
        self.movementDuration = movementDuration
        self.equipment = equipment
    }
    
    init() {
    }
}
