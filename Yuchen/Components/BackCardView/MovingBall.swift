//
//  MovingBall.swift
//  Yuchen
//
//  Created by Fall2024 on 10/12/24.
//

import SwiftUI

struct MovingBall: View {
    @State private var moveRight = true
        
        var body: some View {
            GeometryReader { geometry in
                let ballSize: CGFloat = 30
                let maxX = geometry.size.width + 2*ballSize
                let minX: CGFloat = -2*ballSize
                
                Circle()
                    .fill(moveRight ? Color.red : Color.orange)
                    .frame(width: ballSize, height: ballSize)
                    .position(x: moveRight ? maxX : minX, y: geometry.size.height / 2)
                    .animation(
                        Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: true),
                        value: moveRight
                    )
                    .onAppear {
                        moveRight.toggle()
                    }
            }
            .frame(height: 30) // 设置小球运动区域的高度
        }
}

//#Preview {
//    MovingBall()
//}
