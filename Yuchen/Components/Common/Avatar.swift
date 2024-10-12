//
//  Avatar.swift
//  Yuchen
//
//  Created by Fall2024 on 9/7/24.
//

import SwiftUI

enum AvatarSize:String {
    case small = "small"
    case big = "big"
}

struct Avatar: View {
    var base64String: String
    var avatarSize: AvatarSize
    
    var body: some View {
        switch avatarSize{
        case .small:
            if let uiImage = decodeBase64ToImage(base64String: base64String){
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .shadow(radius: 3)
                
            }else{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .shadow(radius: 3)
            }
        case .big:
            if let uiImage = decodeBase64ToImage(base64String: base64String){
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 5)
                    .padding(.leading, 10)
            }else{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 5)
                    .padding(.leading, 10)
            }
        }
    }
}
