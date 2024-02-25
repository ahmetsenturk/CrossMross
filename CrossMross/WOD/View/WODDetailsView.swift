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
    // TODO: Edit sheeti ile create wod aynı olacak, bunun için bir dizayn düşünelim öncelik bu
    // Sonrasında timer çalıştırma işine bakalım, ona bakarken wod ve workoutları detaylandırmak da gerekecek. Yani öncelik wod workout yapısını iyice oturtmak ve timer işini yapmak
    
    
    
    // TODO: This view needs to be scrollable as well
    // TODO: Put the name in the middle
    // Handle the long names for the workouts
    // Omit the tab item when navigating into this view
    
    var body: some View {
        Group {
            ScrollView {
                VStack {
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
                    HStack {
                        HStack {
                            Image(systemName: "stopwatch")
                                .imageScale(.medium)
                                .bold()
                            Text(WOD.formatTimeInterval(wod.getTotalDuration()))
                        }
                        .foregroundStyle(.white)
                        .applyTagModifier(color: .blue)
                        HStack {
                            Image(systemName: wod.getTypeIcon())
                                .imageScale(.medium)
                            Text(wod.getTypeName())
                        }
                        .foregroundStyle(.white)
                        .applyTagModifier(color: .purple)
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    VStack {
                        ForEach(wod.workouts, id: \.name) { workout in
                            WorkoutDetailsView(workout: workout)
                        }
                        // TODO: Buraya her bir workout için bir WorkoutDetails View'ı çağıracağız
                    }
                    .applyCustomModifier()
                    // FIXME: This is buggy when returning from the destination
                    SlideToAction(completed: $isStarted)
                        .navigationDestination(isPresented: $isStarted) {
                            TimerView()
                        }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $showEditWorkout) {
                    EditWODView(wod: wod)
                }
            }
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
