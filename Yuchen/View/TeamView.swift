//
//  TeamView.swift
//  Yuchen
//
//  Created by Fall2024 on 9/27/24.
//

import SwiftUI
import SwiftData

struct TeamView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var dataManager: DataManager
    @Query private var persons: [DukePerson]
    
    var groupedTeams: [String: [DukePerson]] {
//        let teams = persons.filter { $0.role == .Student || $0.role == .TA || $0.role == .Other }
        let grouped = Dictionary(grouping: persons) { person in
            person.team.isEmpty || person.role != .Student ? "Not Applicable" : person.team
        }
        return grouped
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(groupedTeams.keys.sorted(), id: \.self) { teamName in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(teamName)
                                    .font(.title2)
                                    .bold()
                                    .padding(.horizontal, 16)

                                
                                LazyVGrid(columns: columns, spacing: 20) {
                                    // 对于“Not Applicable”组，显示所有人员；其他组可选择性限制人数
//                                    let members = teamName == "Not Applicable" ? groupedTeams[teamName]! : groupedTeams[teamName]!.prefix(upTo: 3)
                                    
                                    ForEach(groupedTeams[teamName]!) { person in
                                        NavigationLink(destination: PersonDetail(person: person).environmentObject(dataManager)) {
                                            VStack {
                                                Avatar(base64String: person.picture, avatarSize: .small)
                                                
                                                Text("\(person.fName) \(person.lName)")
                                                    .font(.caption)
                                                    .foregroundColor(.primary)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                .navigationTitle("Teams")
            }
        }
    
}

#Preview {
    TeamView()
}
