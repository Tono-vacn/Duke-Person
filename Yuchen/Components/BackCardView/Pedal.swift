import SwiftUI

struct Petal: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addCurve(to: CGPoint(x: width, y: height / 2),
                      control1: CGPoint(x: width * 0.75, y: 0),
                      control2: CGPoint(x: width, y: height * 0.25))
        path.addCurve(to: CGPoint(x: width / 2, y: height),
                      control1: CGPoint(x: width, y: height * 0.75),
                      control2: CGPoint(x: width * 0.75, y: height))
        path.addCurve(to: CGPoint(x: 0, y: height / 2),
                      control1: CGPoint(x: width * 0.25, y: height),
                      control2: CGPoint(x: 0, y: height * 0.75))
        path.addCurve(to: CGPoint(x: width / 2, y: 0),
                      control1: CGPoint(x: 0, y: height * 0.25),
                      control2: CGPoint(x: width * 0.25, y: 0))
        
        return path
    }
}
