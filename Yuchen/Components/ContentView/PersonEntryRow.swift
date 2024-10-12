//
//  PersonRow.swift
//  Yuchen
//
//  Created by Fall2024 on 9/6/24.
//

//import Foundation
import SwiftUI

struct PersonEntryRow: View {
    var person:DukePerson
//    @EnvironmentObject var modelData: ModelData
    var body: some View {
        
        HStack(spacing: 25) {
            Avatar(base64String: person.picture, avatarSize: .small)
            VStack(alignment: .leading, spacing: 5) {
                Text(person.fName+" "+person.lName)
                    .font(.headline)
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
                Text("Program: " + person.program.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Plan: " + person.plan.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }.padding()
    }
}

//struct PersonRow_Preview: PreviewProvider {
//    static var previews: some View {
//        PersonEntryRow(person: ModelData().persons["test"]!)
//            .environmentObject(ModelData())
//            .previewLayout(.fixed(width: 300, height: 70))
//    }
//}

