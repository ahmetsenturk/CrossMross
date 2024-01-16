//
//  EditWODView.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 25.12.23.
//

import Foundation
import SwiftUI

// TODO: Bu basically CreateWODView'in kopyası, içindeki elementları reusable yapalım
struct EditWODView: View {
    @State var wod: WOD
    @State private var showAddWorkout = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("WOD Details") {
                    TextField("Name", text: $wod.name)
                    Picker("Type", selection: $wod.type) {
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
                    // TODO: Buradaki her bir cell'in de editable olması lazım
                    // Sonrasında AddWorkoutView'in EditWorkoutView'i olmalı ve oraya redirect etmeli
                    ForEach(wod.workouts, id: \.name) { workout in
                        HStack {
                            Text(workout.name)
                            Text(workout.type.rawValue)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddWorkout) {
                // TODO: Burada yeni bir sheet açmaktansa başka bir yöntem düşünelim
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
    EditWODView(wod: WOD.mockWOD())
}

