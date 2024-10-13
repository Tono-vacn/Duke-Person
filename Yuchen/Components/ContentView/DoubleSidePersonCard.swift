//
//  DoubleSidePersonCard.swift
//  Yuchen
//
//  Created by Fall2024 on 10/12/24.
//

import SwiftUI
import SwiftData

struct DoubleSidePersonCard: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dataManager: DataManager
    
    var person: DukePerson
    
    @State private var isFlipped = false
    @State private var animateFlip = false
    
    var body: some View {
            FlippableCard(
                front: PersonDetail(person: person),
                back: BackPersonView()
            )
            .background(HideTabBarView())
            .padding()
        }
    
//    var body: some View {
//        VStack {
//                    Spacer()
//                    
//                    ZStack {
//                        // 前面
//                        if !isFlipped {
//                            PersonDetail(person: person)
//                        } else {
//                            // 背面
//                            BackPersonView().transition(.flipFromRight)
//                        }
//                    }
////                    .frame(maxWidth: .infinity, maxHeight: .infinity)
////                    .rotation3DEffect(
////                        .degrees(flipDegrees),
////                        axis: (x: 0, y: 1, z: 0)
////                    )
//                    .onTapGesture {
//                        withAnimation(.easeInOut(duration: 0.6)) {
//                            isFlipped.toggle()
//                        }
//                    }
//                    
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                .background(HideTabBarView())
//    }
    
//    func flipCard() {
//        withAnimation(Animation.easeInOut(duration: 0.8)) {
//            flipDegrees += 180
//            isFlipped.toggle()
//        }
//    }
}

//extension AnyTransition {
//    static var flipFromRight: AnyTransition {
//        AnyTransition.asymmetric(
//            insertion: .scale.combined(with: .opacity),
//            removal: .scale.combined(with: .opacity)
//        )
//    }
//}

//#Preview {
//    let previewContext = ModelContext(ModelConfiguration(isStoredInMemoryOnly: true))
//    DoubleSidePersonCard(person: DukePerson(DUID: 123, netID: "test123", fName: "test", lName: "test", from: "test", hobby: "test", languages: ["test"], moviegenre: "test", gender: .Male, role: .Other, program: .BA, plan: .CS, team: "test", picture: "")).environmentObject(DataManager())
//}
