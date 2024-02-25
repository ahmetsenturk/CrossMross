//
//  MaxRecord.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 15.01.24.
//

import Foundation

class MaxRecord: Identifiable {
    var id: UUID
    var name: String // TODO: Bunun için ayrı bir model olmalı (movement'ın içindeki name ile aynı)
    var weight: Double
    var rep: Int
    // TODO: Daha sonrasında buna süreli/mesafeli hareketler için de giriş yapalım
    
    init(name: String, weight: Double, rep: Int) {
        self.id = UUID()
        self.name = name
        self.weight = weight
        self.rep = rep
    }
    
    static func mockMaxRecord() -> MaxRecord {
        return MaxRecord(name: "Deadlift", weight: 130, rep: 1)
    }
    
    static func mockMaxRecords() -> [MaxRecord] {
        let r1 = MaxRecord(name: "Deadlift", weight: 130, rep: 1)
        let r2 = MaxRecord(name: "Clean", weight: 100, rep: 1)
        let r3 = MaxRecord(name: "Squat", weight: 230, rep: 2)
        let r4 = MaxRecord(name: "Bench Press", weight: 120, rep: 1)
        return [r1, r2, r3, r4]
    }
}
