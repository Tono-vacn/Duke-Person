//
//  BackPersonView.swift
//  Yuchen
//
//  Created by Fall2024 on 10/12/24.
//

import SwiftUI

struct BackPersonView: View {
    @State private var animateImage = false
    @State private var animateGraphic = false
        
        var body: some View {
            VStack(alignment: .center, spacing: 20) {
                // 1. 富文本
                Text("🎉 Thank you for using DukePerson App 🎉\n")
                    .font(.headline)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                ColorChangingSeparator()
//                    .frame(width:100, height: 4)
//                    .fixedSize()
                                .padding(.horizontal, 20)
                
                // 2. 静态图片
                HStack{
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                    Image(systemName: "flame.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.orange)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                    Image(systemName: "flame.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.orange)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                }
                
               
//                ColorChangingSeparatorReverse()
////                    .frame(width:100, height: 4)
////                    .fixedSize()
//                                .padding(.horizontal, 20)
                // 3. 动画图片
//                Image(systemName: "flame.fill")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(.red)
//                    .offset(y: animateImage ? -20 : 20)
//                    .animation(
//                        Animation.easeInOut(duration: 1)
//                            .repeatForever(autoreverses: true),
//                        value: animateImage
//                    )
//                    .onAppear {
//                        animateImage = true
//                    }

                AnimatedFlower()
                               .frame(width: 100, height: 100)
                               .shadow(radius: 5)
                Spacer().frame(height: 20)
                MovingBall().frame(width: 100, height: 30)
                
                TimeView().padding()
                
                
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.yellow, .pink, .orange]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .cornerRadius(15)
            .shadow(radius: 5)
        }
}

struct CustomGraphic: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // 示例：绘制一个简单的五边形
        let sides = 5
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        for i in 0..<sides {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
            let point = CGPoint(x: center.x + CGFloat(cos(angle)) * radius,
                                y: center.y + CGFloat(sin(angle)) * radius)
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

#Preview {
    BackPersonView()
}
