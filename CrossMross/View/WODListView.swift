//
//  WODListView.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 25.12.23.
//

import Foundation
import SwiftUI

struct WODListView: View {
    @Binding var wods: [WOD]
    @State var presentCreateWOD = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("WODs")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {
                    self.presentCreateWOD = true
                }) {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }
            }
            .padding()
            ScrollView(Axis.Set.vertical) {
                ForEach(wods, id: \.name) { wod in
                    NavigationLink(destination: WODDetailsView(wod: wod)) {
                        WODCardView(wod: wod)
                    }
                    .foregroundStyle(.primary)
                }
            }
            .sheet(isPresented: $presentCreateWOD) {
                //AddWorkout(workouts: $workouts)
            }
        }
    }
}

#Preview {
    WODListView(wods: .constant(WOD.mockWODs()))
}
