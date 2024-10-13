//
//  DotTimer.swift
//  Yuchen
//
//  Created by Fall2024 on 10/12/24.
//

import SwiftUI

let digitPatterns: [Int: [[Int]]] = [
    0: [
        [1, 1, 1],
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
        [1, 1, 1],
    ],
    1: [
        [0, 0, 1],
        [0, 0, 1],
        [0, 0, 1],
        [0, 0, 1],
        [0, 0, 1],
    ],
    2: [
        [1, 1, 1],
        [0, 0, 1],
        [1, 1, 1],
        [1, 0, 0],
        [1, 1, 1],
    ],
    3: [
        [1, 1, 1],
        [0, 0, 1],
        [1, 1, 1],
        [0, 0, 1],
        [1, 1, 1],
    ],
    4: [
        [1, 0, 1],
        [1, 0, 1],
        [1, 1, 1],
        [0, 0, 1],
        [0, 0, 1],
    ],
    5: [
        [1, 1, 1],
        [1, 0, 0],
        [1, 1, 1],
        [0, 0, 1],
        [1, 1, 1],
    ],
    6: [
        [1, 1, 1],
        [1, 0, 0],
        [1, 1, 1],
        [1, 0, 1],
        [1, 1, 1],
    ],
    7: [
        [1, 1, 1],
        [0, 0, 1],
        [0, 0, 1],
        [0, 0, 1],
        [0, 0, 1],
    ],
    8: [
        [1, 1, 1],
        [1, 0, 1],
        [1, 1, 1],
        [1, 0, 1],
        [1, 1, 1],
    ],
    9: [
        [1, 1, 1],
        [1, 0, 1],
        [1, 1, 1],
        [0, 0, 1],
        [1, 1, 1],
    ]
]


struct DotView: View {
    var isActive: Bool
    
    var body: some View {
        Circle()
            .fill(isActive ? Color.red : Color.gray.opacity(0.3))
            .frame(width: 10, height: 10)
    }
}

struct DigitView: View {
    var digit: Int
    
    var body: some View {
        let pattern = digitPatterns[digit] ?? [[Int]](repeating: [Int](repeating: 0, count: 3), count: 5)
        
        VStack(spacing: 2) {
            ForEach(0..<pattern.count, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<pattern[row].count, id: \.self) { column in
                        DotView(isActive: pattern[row][column] == 1)
                    }
                }
            }
        }
    }
}

struct ColonView: View {
    var body: some View {
        VStack(spacing: 2) {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
        }
    }
}

struct TimeView: View {
    @State private var currentTime: String = ""
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(currentTime.map { String($0) }, id: \.self) { char in
                if let digit = Int(char) {
                    DigitView(digit: digit)
                } else {
                    // 如果需要显示冒号等符号，可以创建额外的视图
                    ColonView()
                }
            }
        }
        .onAppear(perform: updateTime)
    }
    
    func updateTime() {
        // 初始化时间并启动定时器
        currentTime = getCurrentTime()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            currentTime = getCurrentTime()
        }
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss" // 根据需要设置时间格式
        return formatter.string(from: Date())
    }
}


//#Preview {
//    DotTimer()
//}
