//
//  Toast.swift
//  Yuchen
//
//  Created by Fall2024 on 9/22/24.
//

import SwiftUI

struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.bottom, 50)
    }
}
