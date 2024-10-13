//
//  ColorChangingSeparator.swift
//  Yuchen
//
//  Created by Fall2024 on 10/12/24.
//

import SwiftUI

struct ColorChangingSeparator: View {
    @State private var animateGraphic = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [.red, .orange, .yellow, .white , .yellow, .orange, .red]),
                    startPoint: animateGraphic ? .leading : .trailing,
                    endPoint: animateGraphic ? .trailing : .leading
                )
            )
            .frame(width: 300, height: 5)
            .animation(
                Animation.easeInOut(duration: 5)
                    .repeatForever(autoreverses: true),
                value: animateGraphic
            )
            .onAppear {
                animateGraphic.toggle()
            }
    }
}

struct ColorChangingSeparatorReverse: View {
    @State private var animateGraphic = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [ .yellow, .orange, .red, .orange, .yellow]),
                    startPoint: animateGraphic ? .leading : .trailing,
                    endPoint: animateGraphic ? .trailing : .leading
                )
            )
            .frame(width: 300, height: 5)
            .animation(
                Animation.easeInOut(duration: 5)
                    .repeatForever(autoreverses: true),
                value: animateGraphic
            )
            .onAppear {
                animateGraphic.toggle()
            }
    }
}
