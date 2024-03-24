//
//  WODDetailsView.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 26.12.23.
//

import Foundation
import SwiftUI

struct WODDetailsView: View {
    var wod: WOD
    @State private var edit = false
    @State private var showEditWorkout = false
    @State private var isStarted = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(wod.name)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: {
                            self.edit = true
                            self.showEditWorkout = true
                            // TODO: Edit fonksiyonu
                        }) {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                        }
                    }
                    .padding(.bottom, 5)
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "stopwatch")
                                .imageScale(.medium)
                                .bold()
                            Text(WOD.formatTimeInterval(wod.getTotalDuration()))
                        }
                        .foregroundStyle(.blue)
                        HStack {
                            Image(systemName: wod.getTypeIcon())
                                .imageScale(.medium)
                            Text(wod.getTypeName())
                        }
                        .foregroundStyle(.purple)
                    }
                    .padding()
                    VStack {
                        ForEach(wod.workouts, id: \.name) { workout in
                            WorkoutDetailsView(workout: workout)
                                .padding()
                        }
                        Spacer()
                    }
                    .frame(minHeight: 400) // TODO: Fix this constant
                    .background(
                        Image(colorScheme == .dark ? "blackboard" : "whiteboard")
                            .resizable()
                    )
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $showEditWorkout) {
                    EditWODView(wod: wod)
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    self.isStarted = true
                }) {
                    Text("Let's start")
                        .font(.custom("Lemon Tuesday", size: 30))
                }
                Spacer()
            }
            .padding()
        }
        .navigationDestination(isPresented: $isStarted) {
            TimerView()
        }
    }
}

// Define your custom ViewModifier
struct CustomModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 2)
    }
}

struct TagModifier: ViewModifier {
    var color: Color
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 35)
            .background(color)
            .cornerRadius(15)
    }
}

// Extension to apply the modifier easily
extension View {
    func applyCustomModifier() -> some View {
        self.modifier(CustomModifier())
    }
    
    func applyTagModifier(color: Color) -> some View {
        self.modifier(TagModifier(color: color))
    }
}

#Preview {
    WODDetailsView(wod: WOD.mockWOD())
}
