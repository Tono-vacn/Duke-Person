//
//  FlipCard.swift
//  Yuchen
//
//  Created by Fall2024 on 10/12/24.
//

import SwiftUI

struct FlippableCard<Front: View, Back: View>: View {
    @State private var isFlipped = false
    @State private var flipDegrees: Double = 0
    
    let front: Front
    let back: Back
    
    var body: some View {
        ZStack {
            front
                .opacity(isFlipped ? 0.0 : 1.0)
                .rotation3DEffect(
                    .degrees(flipDegrees),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            back
                .opacity(isFlipped ? 1.0 : 0.0)
                .rotation3DEffect(
                    .degrees(flipDegrees + 180),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .onTapGesture {
            flipCard()
        }
        .animation(.easeInOut(duration: 0.6), value: flipDegrees)
    }
    
    private func flipCard() {
        if isFlipped {
            flipDegrees -= 180
        } else {
            flipDegrees += 180
        }
        isFlipped.toggle()
    }
}
