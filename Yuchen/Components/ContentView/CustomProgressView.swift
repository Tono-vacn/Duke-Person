//
//  CustomProgressView.swift
//  Yuchen
//
//  Created by Fall2024 on 9/22/24.
//

import SwiftUI

struct CustomProgressView: View {
    var progress: Double // 0.0 to 1.0
    
    var body: some View {
        ZStack {
            // 环形背景
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            // 环形进度
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
            
            // 显示百分比文本
            Text(String(format: "%.0f %%", min(progress, 1.0)*100))
                .font(.title)
                .bold()
        }
        .frame(width: 150, height: 150)
    }
}
