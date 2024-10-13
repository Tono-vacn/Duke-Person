import SwiftUI

struct AnimatedFlower: View {
    @State private var animate = false

    let petalCount: Int = 10
    let petalColor: [Color] = [.red, .pink, .orange]
    let centerColor: Color = .yellow

    var body: some View {
        ZStack {
            // 花心
//            Circle()
//                .fill(centerColor)
//                .frame(width: 50, height: 50)
//                .scaleEffect(animate ? 1.0 : 0.0)
//                .animation(
//                    Animation.easeInOut(duration: 1)
//                        .delay(1),
//                    value: animate
//                )

            // 花瓣
            ForEach(0..<petalCount, id: \.self) { index in
                Petal()
                    .fill(petalColor[index%3])
                    .frame(width: 50, height: 75)
                    .rotationEffect(.degrees(animate ? Double(index+3) * (360.0 / Double(petalCount-3)) : 0), anchor: .bottom)
                    .scaleEffect(animate ? 1.0 : 0.0, anchor: .bottom)
                    .animation(
                        Animation.easeInOut(duration: 3)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}
