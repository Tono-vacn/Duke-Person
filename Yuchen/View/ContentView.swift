//
//  ContentView.swift
//  Yuchen
//
//  Created by Fall2024 on 9/6/24.
//

import SwiftUI
import ECE564Login
import SwiftData

enum SortOption: String, CaseIterable {
    case role = "Role"
    case gender = "Gender"
    case plan = "Plan"
    case program = "Program"
    case firstName = "First Name"
    case lastName = "Last Name"
}

enum DownloadTypeOption: String, CaseIterable, Identifiable {
    case downloadAndReplace = "Download and Replace"
    case downloadAndUpdate = "Download and Update"
    case cancel = "Cancel"
    
    var id: String {
        self.rawValue
    }
}

struct ContentView: View {
    
    //    @EnvironmentObject var modelData: ModelData
    @Environment(\.modelContext) private var context
    @Query private var persons: [DukePerson]
    @EnvironmentObject var dataManager: DataManager
    
    
    @State private var searchText = ""
    @State private var selectedSortOption: SortOption = .role
    
    @State private var showAddEditView = false
    //    @State private var personToEdit: DukePerson? = nil
    @State private var addEditMode: AddEditMode? = nil
    
    @State private var showingToast = false
    @State private var toastMessage = ""
    
    @State private var animateReturn = false
    
    var filteredPersons: [DukePerson] {
        let curpersons = persons.filter { person in
            searchText.isEmpty || person.description.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectedSortOption {
        case .firstName:
            return curpersons.sorted { $0.fName < $1.fName }
        case .lastName:
            return curpersons.sorted { $0.lName < $1.lName }
        default:
            return curpersons
        }
    }
    
    var groupedPersons: [String: [DukePerson]] {
        var dict = [String: [DukePerson]]()
        for person in filteredPersons {
            let key: String
            switch selectedSortOption {
            case .role:
                key = person.role.rawValue
            case .gender:
                key = person.gender.rawValue
            case .plan:
                key = person.plan.rawValue
            case .program:
                key = person.program.rawValue
            default:
                key = "Unknown"
            }
            dict[key, default: []].append(person)
        }
        return dict
    }
    
    
    var body: some View {
        ZStack{
            TabView{
                NavigationView {
                    VStack {
                        // 搜索栏
                        SearchBar(text: $searchText)
                        
                        List {
                            if selectedSortOption == .firstName || selectedSortOption == .lastName {
                                ForEach(filteredPersons, id: \.id) { person in
                                    NavigationLink {
//                                        PersonDetail(person: person).environmentObject(dataManager)
                                        DoubleSidePersonCard(person: person)
                                            .environmentObject(dataManager)
                                            .onDisappear {
                                                withAnimation(.easeInOut(duration: 0.6)) {
                                                    animateReturn.toggle()
                                                }
                                            }
                                    } label: {
                                        PersonEntryRow(person: person)
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button("Edit") {
                                            addEditMode = .edit(person)
                                        }
                                        .tint(.blue)
                                        
                                        Button("Delete", role: .destructive) {
                                            dataManager.deletePerson(person)
                                        }
                                    }
                                }
                            } else {
                                ForEach(groupedPersons.keys.sorted(), id: \.self) { key in
                                    Section(header: Text(key).font(.headline)) {
                                        ForEach(groupedPersons[key]!) { person in
                                            NavigationLink {
//                                                PersonDetail(person: person).environmentObject(dataManager)
                                                DoubleSidePersonCard(person: person)
                                                    .environmentObject(dataManager)
                                                    .onDisappear {
                                                        withAnimation(.easeInOut(duration: 0.6)) {
                                                            animateReturn.toggle()
                                                        }
                                                    }
                                            } label: {
                                                PersonEntryRow(person: person)
                                            }
                                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                                Button("Edit") {
                                                    //                                                personToEdit = person
                                                    ////                                                print(personToEdit?.id)
                                                    //                                                editMode = .edit
                                                    //                                                showAddEditView = true
                                                    addEditMode = .edit(person)
                                                }
                                                .tint(.blue)
                                                
                                                Button("Delete", role: .destructive) {
                                                    dataManager.deletePerson(person)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle()) // 采用圆角分组列表风格
                    }
                    .navigationTitle("Duke Persons") // 页面标题
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading, content: {
                            HStack{
                                Menu {
                                    ForEach(SortOption.allCases, id: \.self) { option in
                                        Button(action: {
                                            selectedSortOption = option
                                        }) {
                                            Text(option.rawValue)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "arrow.up.arrow.down.circle")
                                        .foregroundColor(.blue)
                                }
                                
                                
                            }
                        })
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            HStack{
                                Menu {
                                    ForEach(DownloadTypeOption.allCases) { option in
                                        Button(
                                            action: {
                                                switch option {
                                                case .downloadAndReplace:
                                                    Task{
                                                        await dataManager.fetchPersonData(endPoint: DefaultUrl + AllEndPoint, strategy: .downloadAndReplace)
                                                    }
                                                case .downloadAndUpdate:
                                                    Task{
                                                        await dataManager.fetchPersonData(endPoint: DefaultUrl + AllEndPoint, strategy: .downloadAndUpdate)
                                                    }
                                                case .cancel:
                                                    break
                                                }
                                            },
                                            label: {
                                                Text(option.rawValue)
                                            })
                                    }
                                    
                                } label: {
                                    Image(systemName: "arrow.down.circle")
                                        .foregroundColor(.blue)
                                }
                                
                                Button(action: {
                                    //                                personToEdit = nil
                                    //                                editMode = .add
                                    //                                showAddEditView = true
                                    addEditMode = .add
                                }) {
                                    Image(systemName: "plus")
                                }
                                .foregroundColor(.blue)
                                
                            }
                        })
                    }
                }.tabItem{
                    Label("List", systemImage: "list.bullet")
                }
                TeamView().environmentObject(dataManager).tabItem { Label("Teams", systemImage: "person.3.fill") }
            }
//            .opacity(dataManager.showTab ? 1 : 0)
            ECE564Login()
            
            if dataManager.isDownloading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                CustomProgressView(progress: dataManager.downloadProgress)
            }
        }
        .sheet(item: $addEditMode) { mode in
            switch mode {
            case .add:
                AddEditView(mode:.add, person: nil).environmentObject(dataManager)
            case .edit(let person):
                AddEditView(mode: .edit, person: person, curNetID: getSeperateNetIDAndPassword().0).environmentObject(dataManager)
            }
        }
        .onReceive(dataManager.$successMessage) { message in
            if let message = message {
                toastMessage = message
                withAnimation { // 使用 `withAnimation` 触发动画
                    showingToast = true
                }
                dataManager.successMessage = nil // 重置消息
            }
        }
        .onReceive(dataManager.$errorMessage) { message in
            if let message = message {
                toastMessage = message
                withAnimation { // 使用 `withAnimation` 触发动画
                    showingToast = true
                }
                dataManager.errorMessage = nil // 重置消息
            }
        }
        .toast(isShowing: $showingToast, message: toastMessage)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(ModelData())
//    }
//}
