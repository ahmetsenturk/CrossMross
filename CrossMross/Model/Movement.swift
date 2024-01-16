//
//  Movement.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 25.12.23.
//

import Foundation

class Movement: Identifiable {
    var name: String
    var reps: Int?
    var weight: Double?
    var distance: Double?
    var duration: TimeInterval?
    var equipment: String?
    
    init(name: String, reps: Int? = nil, weight: Double? = nil, distance: Double? = nil, duration: TimeInterval? = nil, equipment: String? = nil) {
        self.name = name
        self.reps = reps
        self.weight = weight
        self.distance = distance
        self.duration = duration
        self.equipment = equipment
    }
    
    static func mockMovement() -> Movement {
        return Movement(name: "Burpee", reps: 12)
    }
    
    static func mockMovements() -> [Movement] {
        let m1 = Movement(name: "Burpee", reps: 12)
        let m2 = Movement(name: "Deadlift", reps: 10, weight: 100, equipment: "Bar")
        let m3 = Movement(name: "KB Push Press", reps: 10, weight: 22, equipment: "KB")
        return [m1, m2, m3]
    }
    
    static func mockCindyMovements() -> [Movement] {
        let m1 = Movement(name: "Pull-Ups", reps: 5)
        let m2 = Movement(name: "Push-Ups", reps: 10)
        let m3 = Movement(name: "Air Squat", reps: 15)
        return [m1, m2, m3]
    }
}
