//
//  CustomSlider.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 25.02.24.
//

import SwiftUI

struct SlideToAction: View {
    @State private var slideAmount = 0.0 // The current amount of slide
    
    private let sliderWidth: CGFloat = 300
    private let screenWidth = UIScreen.main.bounds.width
    
    private var maxSlideAmount: CGFloat {
        return (sliderWidth / 2) - (55 / 2) - 2 // Adjust 60 based on your padding or margins
    }
    private var initialSlideAmount: CGFloat {
        return -(sliderWidth / 2) + (55 / 2) + 2
    }
    
    let completionThreshold = 0.7 // Threshold to consider the action complete
    @Binding var completed: Bool // Whether the slide action is completed

    var body: some View {
        ZStack {
            Capsule()
                .frame(width: sliderWidth, height: 60)
                .foregroundStyle(completed ? .green : .secondary)
                .opacity(0.2)
                .overlay(
                    Text("slide to start")
                        .font(.headline)
                    // TODO: Add shimmer effect here
                )
            Circle()
                .frame(width: 55, height: 55)
                .foregroundColor(.white)
                .shadow(radius: 4)
                .overlay(
                    Image(systemName: "figure.run")
                        .foregroundStyle(.black)
                )
                .offset(x: slideAmount)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation {
                                slideAmount = min(maxSlideAmount, value.translation.width)
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                if slideAmount * 2 / sliderWidth > completionThreshold {
                                    completed = true
                                    slideAmount = UIScreen.main.bounds.width
                                } else {
                                    slideAmount = initialSlideAmount
                                }
                            }
                        }
                )
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 60)
        .padding()
        .onAppear {
            // Reset the state when the view appears
            completed = false // Reset completed state
            slideAmount = initialSlideAmount // Reset slide position
            
        }
    }
}




#Preview {
    SlideToAction(completed: .constant(false))
}
