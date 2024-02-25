//
//  WODCardView.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 22.12.23.
//

import Foundation
import SwiftUI

struct WODCardView: View {
    var wod: WOD
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(wod.name)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Image(systemName: "stopwatch")
                    Text(WOD.formatTimeInterval(wod.getTotalDuration()))
                        .font(.title3)
                }
                .padding(.bottom, 0.5)
                
                HStack {
                    Image(systemName: wod.getTypeIcon())
                        .foregroundStyle(.purple)
                    Text(wod.type.rawValue)
                        .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.purple)
                    Spacer()
                }
                ScrollView(Axis.Set.horizontal) {
                    HStack {
                        Image(systemName: "dumbbell")
                            .foregroundStyle(.orange)
                        ForEach(wod.getAllEquipments(), id: \.self) { equipment in
                            Text(equipment)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.orange)
                        }
                    }
                }
            }
            .padding()
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 2)
            .padding()
        }
    }
}

#Preview {
    WODCardView(wod: WOD.mockWOD())
}
