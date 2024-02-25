//
//  Workout.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 22.12.23.
//

import Foundation

protocol WorkoutProtocol {
    func getTotalDuration() -> TimeInterval
}

/// Workout super class
class Workout: WorkoutProtocol, Identifiable {
    var name: String
    var type: WorkoutType
    var movements: [Movement]
    
    init(name: String, type: WorkoutType, movements: [Movement]) {
        self.name = name
        self.type = type
        self.movements = movements
    }
    
    static func mockCindyWorkouts() -> [Workout] {
        let w1 = AMRAP(name: "", type: WorkoutType.AMRAP, duration: 20 * 60, movements: Movement.mockCindyMovements())
        return [w1]
    }
    
    static func mockWorkouts() -> [Workout] {
        let w1 = AMRAP(name: "The Chief", type: WorkoutType.AMRAP, duration: 19 * 60, movements: Movement.mockMovements())
        let w2 = EMOM(name: "Mikko's Triangle", type: WorkoutType.EMOM, everyDuration: 1 * 60, forDuration: 39 * 60, movements: Movement.mockMovements())
        let w3 = TABATA(name: "Killer HIIT", type: WorkoutType.TABATA, rounds: 4, workDuration: 20, restDuration: 10, movements: Movement.mockMovements())
        return [w1, w2, w3]
    }
    
    static func mockWorkout() -> Workout {
        return TABATA(name: "Killer HIIT", type: WorkoutType.TABATA, rounds: 4, workDuration: 20, restDuration: 10, movements: Movement.mockMovements())
    }
    
    func getTotalDuration() -> TimeInterval {
        fatalError()
    }
    
    func getDisplayText() -> String {
        fatalError()
    }
}

/// Child classes for specific workout types
class AMRAP: Workout {
    var duration: TimeInterval
    
    init(name: String, type: WorkoutType, duration: TimeInterval, movements: [Movement]) {
        self.duration = duration
        super.init(name: name, type: type, movements: movements)
    }
    
    override func getTotalDuration() -> TimeInterval {
        return self.duration
    }
    
    override func getDisplayText() -> String {
        return "As many rounds as possible in \(self.duration.description) mins."
    }
}

class FORTIME: Workout {
    var duration: TimeInterval
    
    init(name: String, type: WorkoutType, duration: TimeInterval, movements: [Movement]) {
        self.duration = duration
        super.init(name: name, type: type, movements: movements)
    }
    
    override func getTotalDuration() -> TimeInterval {
        return self.duration
    }
    
    override func getDisplayText() -> String {
        return "Complete the workout as fast as possible. Time cap - \(self.duration)."
    }
}

class EMOM: Workout {
    var everyDuration: TimeInterval
    var forDuration: TimeInterval
    
    init(name: String, type: WorkoutType, everyDuration: TimeInterval, forDuration: TimeInterval, movements: [Movement]) {
        self.everyDuration = everyDuration
        self.forDuration = forDuration
        super.init(name: name, type: type, movements: movements)
    }
    
    override func getTotalDuration() -> TimeInterval {
        return self.forDuration
    }
    
    override func getDisplayText() -> String {
        // TODO: The following text could be enhanced
        return "Every \(self.everyDuration) mins on \(self.forDuration)."
    }
}

class TABATA: Workout {
    var rounds: Int
    var workDuration: TimeInterval
    var restDuration: TimeInterval
    
    init(name: String, type: WorkoutType, rounds: Int, workDuration: TimeInterval, restDuration: TimeInterval, movements: [Movement]) {
        self.rounds = rounds
        self.workDuration = workDuration
        self.restDuration = restDuration
        super.init(name: name, type: type, movements: movements)
    }
    
    override func getTotalDuration() -> TimeInterval {
        return Double(self.rounds) * (workDuration + restDuration)
    }
    
    override func getDisplayText() -> String {
        // TODO: Fix me
        return "For \(self.rounds.description) rounds - \(self.workDuration.description) seconds work \(self.restDuration.description) seconds rest"
    }
}

enum WorkoutType: String, CaseIterable {
    case AMRAP = "AMRAP"
    case EMOM = "EMOM"
    case FORTIME = "FOR TIME"
    case TABATA = "TABATA"
}
