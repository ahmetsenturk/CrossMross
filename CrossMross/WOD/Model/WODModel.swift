//
//  WODModel.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 22.12.23.
//

import Foundation
import Observation

// TODO: Convert these models into SwiftData Models
@Observable class WOD: Identifiable {
    var name: String
    var type: WODType
    var workouts: [Workout]
    
    init(name: String, type: WODType, workouts: [Workout]) {
        self.name = name
        self.type = type
        self.workouts = workouts
    }
    
    static func mockWOD() -> WOD {
        return WOD(name: "The Seven", type: WODType.ENDURANCE, workouts: Workout.mockWorkouts())
    }
    
    static func mockWODs() -> [WOD] {
        let w1 = WOD(name: "The Seven", type: WODType.ENDURANCE, workouts: Workout.mockCindyWorkouts())
        let w2 = WOD(name: "Cindy", type: WODType.ENDURANCE, workouts: Workout.mockWorkouts())
        return [w1, w2]
    }
    
    func getTotalDuration() -> TimeInterval {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        var duration: TimeInterval = 0
        for workout in workouts {
            duration += workout.getTotalDuration()
        }
        return duration
    }
    
    func getBackground() -> String {
        switch self.type {
        case WODType.ENDURANCE:
            return "endurance-1"
        case WODType.OLYLIFTING:
            return "olylifting-1"
        case WODType.STRENGTH:
            return "strenght-1"
        }
    }
    
    func getTypeIcon() -> String {
        switch self.type {
        case .ENDURANCE:
            return "figure.step.training"
        case .OLYLIFTING:
            return "figure.strengthtraining.traditional"
        case .STRENGTH:
            return "dumbbell.fill"
        }
    }
    
    func getTypeName() -> String {
        switch self.type {
        case .ENDURANCE:
            return "Endurance"
        case .OLYLIFTING:
            return "Olylifting"
        case .STRENGTH:
            return "Strength"
        }
    }
    
    static func formatTimeInterval(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60

        var result = ""

        if hours > 0 {
            result += "\(hours) hour" + (hours > 1 ? "s" : "")
        }

        if minutes > 0 {
            if !result.isEmpty {
                result += " "
            }
            result += "\(minutes) min" + (minutes > 1 ? "s" : "")
        }

        if result.isEmpty {
            result = "0 mins"
        }

        return result
    }
    
    
    func getAllEquipments() -> [String] {
        var equipments: [String] = []
        for workout in workouts {
            for movement in workout.movements {
                if let equipment = movement.equipment {
                    if (!equipments.contains(equipment)) {
                        equipments.append(equipment)
                    }
                }
            }
        }
        if (equipments.isEmpty) {
            return ["No equipment needed :)"]
        } else {
            equipments.insert("Equipments: ", at: 0)
        }
        return equipments
    }
}

enum WODType: String {
    case ENDURANCE
    case OLYLIFTING
    case STRENGTH
}
