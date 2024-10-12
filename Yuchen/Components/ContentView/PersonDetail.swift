//
//  PersonDetail.swift
//  Yuchen
//
//  Created by Fall2024 on 9/6/24.
//

import SwiftUI

struct PersonDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dataManager: DataManager
    
    var person: DukePerson
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Spacer()
            HStack(alignment: .top, spacing: 20) {
                Avatar(base64String: person.picture, avatarSize: .big)
                VStack(alignment: .leading, spacing: 8) {
                    Text(person.fName + " " + person.lName)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("DUID: \(String(person.DUID))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("NetID: " + person.netID)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Email: " + person.email2)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(UIColor.secondarySystemBackground))
                        .shadow(radius: 5)
                )
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    Text("Program: " + person.program.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text("Plan: " + person.plan.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Divider()
                    Text("Hobby: " + person.hobby)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("From: " + person.from)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Gender: " + person.gender.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider() // 分隔线
                
                // 电影和语言
                Group {
                    Text("Favorite Movie Genre: " + person.moviegenre)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Languages: " + person.languages.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider() // 分隔线
                
                // 描述信息
                Group {
                    Text("Description: " + person.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading) // 允许多行描述
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(radius: 5)
            )
            
            Spacer()
            Spacer()
        }.padding(
            .horizontal, 20
            
        ).background(HideTabBarView())
    }
}

//struct PersonDetailPreview: PreviewProvider {
//    static var previews: some View {
//        PersonDetail(person: ModelData().persons["test"]!)
//            .environmentObject(ModelData())
//            .previewLayout(.fixed(width: 300, height: 70))
//    }
//}

