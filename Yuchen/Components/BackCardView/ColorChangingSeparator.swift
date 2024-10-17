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
//                animateGraphic.toggle()
                DispatchQueue.main.async {
                    animateGraphic = true // 确保在视图出现时动画正常开始
                }
            }
    }
}


//struct ColorChangingSeparator: View {
//    @State private var animateGradient = false
//
//    var body: some View {
//        LinearGradient(
//            gradient: Gradient(colors: [.red, .orange, .yellow, .white, .yellow, .orange, .red]),
//            startPoint: .leading,
//            endPoint: .trailing
//        )
//        .frame(width: 600, height: 5) // 渐变的宽度比视图宽度大，以便有空间移动
//        .offset(x: animateGradient ? -300 : 0) // 根据动画状态移动渐变
//        .mask(
//            RoundedRectangle(cornerRadius: 25)
//                .frame(width: 300, height: 5) // 定义遮罩形状
//        )
//        .onAppear {
//            withAnimation(
//                Animation.easeInOut(duration: 5)
//                    .repeatForever(autoreverses: true)
//            ) {
//                animateGradient.toggle()
//            }
//        }
//    }
//}
//
//struct ColorChangingSeparatorReverse: View {
//    @State private var animateGradient = false
//
//    var body: some View {
//        LinearGradient(
//            gradient: Gradient(colors: [ .yellow, .orange, .red, .orange, .yellow]),
//            startPoint: .leading,
//            endPoint: .trailing
//        )
//        .frame(width: 600, height: 5) // 渐变的宽度比视图宽度大，以便有空间移动
//        .offset(x: animateGradient ? -300 : 0) // 根据动画状态移动渐变
//        .mask(
//            RoundedRectangle(cornerRadius: 25)
//                .frame(width: 300, height: 5) // 定义遮罩形状
//        )
//        .onAppear {
//            withAnimation(
//                Animation.easeInOut(duration: 5)
//                    .repeatForever(autoreverses: true)
//            ) {
//                animateGradient.toggle()
//            }
//        }
//    }
//}

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
//                animateGraphic.toggle()
                DispatchQueue.main.async {
                    animateGraphic = true // 确保在视图出现时动画正常开始
                }
            }
    }
}
