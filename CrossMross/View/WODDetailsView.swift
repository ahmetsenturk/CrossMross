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
                        VStack {
                            Image(systemName: "stopwatch")
                                .imageScale(.large)
                                .bold()
                            Text(WOD.formatTimeInterval(wod.getTotalDuration()))
                                .font(.title3)
                        }
                        .foregroundStyle(.blue)
                        .applyCustomModifier()
                        .padding()
                        VStack {
                            Image(systemName: wod.getTypeIcon())
                                .imageScale(.large)
                            Text(wod.getTypeName())
                                .font(.title3)
                        }
                        .foregroundStyle(.purple)
                        .applyCustomModifier()
                    }
                    VStack {
                        Text("Details")
                            .font(.title2)
                            .bold()
                        ForEach(wod.workouts, id: \.name) { workout in
                            WorkoutDetailsView(workout: workout)
                        }
                        // TODO: Buraya her bir workout için bir WorkoutDetails View'ı çağıracağız
                    }
                    .applyCustomModifier()
                    // TODO: Buraya da bir tane start butonu koyup antrenmanı başlatacağız timer ile
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $showEditWorkout) {
                    EditWODView(wod: wod)
                }
            }
            .background(
                Image(wod.getBackground())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.2)
            )
        }
    }
}

// Define your custom ViewModifier
struct CustomModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 2)
    }
}

// Extension to apply the modifier easily
extension View {
    func applyCustomModifier() -> some View {
        self.modifier(CustomModifier())
    }
}

#Preview {
    WODDetailsView(wod: WOD.mockWOD())
}
