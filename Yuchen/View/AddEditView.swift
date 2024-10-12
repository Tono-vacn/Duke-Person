//
//  AddEditView.swift
//  Yuchen
//
//  Created by Fall2024 on 9/22/24.
//

import SwiftUI

enum AddEditMode: Identifiable {
    case add
    case edit(DukePerson)
    
    var id: String {
        switch self {
        case .add:
            return "add"
        case .edit(let person):
            return person.id
        }
    }
}

enum AddEditModeType {
    case add
    case edit
}

struct AddEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @EnvironmentObject var dataManager: DataManager
    
    var mode: AddEditModeType
    var person: DukePerson? // nil for add, non-nil for edit
    var curNetID: String?
    
    @State private var DUID: String = ""
    @State private var netID: String = ""
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var from: String = ""
    @State private var hobby: String = ""
    @State private var languages: String = ""
    @State private var moviegenre: String = ""
    @State private var gender: Gender = .Unknown
    @State private var role: Role = .Unknown
    @State private var program: Program = .NotApplicable
    @State private var plan: Plan = .NotApplicable
    @State private var team: String = ""
    @State private var picture: String = ""
    @State private var email1: String = ""
    
    @State private var uploadToServer: Bool = false // For Edit mode
    
    @State private var showingImagePicker = false
    @State private var selectedUIImage: UIImage? = nil
    @State private var base64ImageString: String = ""
    
    @State private var showingToast = false
    @State private var toastMessage = ""
    
    @State private var emailValid: Bool = true
    @State private var netIDValid: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Avatar")) {
                    // 显示当前头像或选择的头像
                    Avatar(base64String: selectedUIImage != nil ? base64ImageString : (person?.picture ?? ""), avatarSize: .big)
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                    
                    // 选择头像按钮
                    Button(action: {
                        self.showingImagePicker = true
                    }) {
                        Text("Pick New Avatar")
                    }
                }
                
                Section(header: Text("Basic Information")) {
                    if mode == .add {
                        TextField("DUID", text: $DUID)
                            .keyboardType(.numberPad)
                            .onChange(of: DUID) { _, newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered != newValue {
                                    self.DUID = filtered
//                                    dataManager.errorMessage = "DUID should only contain numbers"
                                }
                            }
                    } else {
                        Text("DUID: \(person?.DUID ?? 0)")
                    }
                    
                    if mode == .add {
                        TextField("NetID", text: $netID)
                            .autocapitalization(.none) // 关闭自动大写
                            .disableAutocorrection(true)
                            .onChange(of: netID) { _, newValue in
                                // 仅允许小写字母和数字
                                let prefiltered = newValue.lowercased().filter { $0.isNumber }
                                if prefiltered == newValue.lowercased() {
                                    netID = ""
                                    return
                                }
                                let filtered = newValue.lowercased().filter { $0.isLowercase || $0.isNumber }
                                if filtered != newValue.lowercased() {
                                    netID = filtered
//                                    dataManager.errorMessage = "netId should only contain number and letters"
                                }
                                let letters = filtered.prefix { $0.isLetter }
                                let numbers = filtered.dropFirst(letters.count).prefix { $0.isNumber }
                                let reconstructed = letters + numbers
                                if reconstructed != filtered {
                                    netID = String(reconstructed)
                                }
                            }
//                        if !netIDValid {
//                            Text("Please enter a valid email address.")
//                                .font(.caption)
//                                .foregroundColor(.red)
//                        }
                    } else {
                        Text("NetID: \(person?.netID ?? "")")
                    }
                    
                    TextField("First Name", text: $fName)
                        .autocapitalization(.none)
                        .onChange(of: fName){
                            _, newValue in self.fName = newValue.capitalizingFirstLetter()
                        }
                    TextField("Last Name", text: $lName)
                        .autocapitalization(.none)
                        .onChange(of: lName){
                            _, newValue in self.lName = newValue.capitalizingFirstLetter()
                        }
                }
                
                Section(header: Text("Personal Details")) {
                    TextField("From", text: $from)
                    TextField("Hobby", text: $hobby)
                    TextField("Languages (comma separated)", text: $languages)
                    TextField("Movie Genre", text: $moviegenre)
                }
                
                Section(header: Text("Attributes")) {
                    Picker("Gender", selection: $gender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    
                    Picker("Role", selection: $role) {
                        ForEach(Role.allCases, id: \.self) { role in
                            Text(role.rawValue).tag(role)
                        }
                    }
                    
                    Picker("Program", selection: $program) {
                        ForEach(Program.allCases, id: \.self) { program in
                            Text(program.rawValue).tag(program)
                        }
                    }
                    
                    Picker("Plan", selection: $plan) {
                        ForEach(Plan.allCases, id: \.self) { plan in
                            Text(plan.rawValue).tag(plan)
                        }
                    }
                }
                
                Section(header: Text("Other Details")) {
                    TextField("Team", text: $team)
//                    TextField("Picture URL", text: $picture)
                    TextField("Email", text: $email1)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: email1) { _, newValue in
                            if !newValue.isValidEmail() && !newValue.isEmpty {
//                                dataManager.errorMessage = "Please enter a valid email address."
                            }
                            emailValid = newValue.isValidEmail()
                            
                        }
                        .foregroundColor(emailValid ? .primary : .red)
                    if (!emailValid) {
                        Text("Please enter a valid email address.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                if mode == .edit, let person = person, person.netID == curNetID {
                    Section {
                        Toggle("Upload to Server", isOn: $uploadToServer)
                    }
                }
            }
            .navigationTitle(mode == .add ? "Add Person" : "Edit Person")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    //                    print("save")
                    savePerson()
                }
                    .disabled(!isValid())
            )
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedUIImage)
                    .onDisappear {
                        if let uiImage = selectedUIImage {
                            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                                base64ImageString = jpegData.base64EncodedString()
                                picture = base64ImageString
                            }
                        }
                    }
            }
            .onAppear {
                if mode == .edit, let person = person {
                    DUID = String(person.DUID)
                    netID = person.netID
                    fName = person.fName
                    lName = person.lName
                    from = person.from
                    hobby = person.hobby
                    languages = person.languages.joined(separator: ", ")
                    moviegenre = person.moviegenre
                    gender = person.gender
                    role = person.role
                    program = person.program
                    plan = person.plan
                    team = person.team
                    picture = person.picture
                    email1 = person.email1 ?? ""
                    
                    if let existingImage = decodeBase64ToImage(base64String: person.picture) {
                        selectedUIImage = existingImage
                        base64ImageString = person.picture
                    }
                }
            }
        }
    }
    
    func isValid() -> Bool {
        if mode == .add {
            return !DUID.isEmpty && !netID.isEmpty && !fName.isEmpty && !lName.isEmpty && email1.isValidEmail()
        } else {
            return !fName.isEmpty && !lName.isEmpty
        }
    }
    
    func savePerson() {
        if mode == .add {
            guard let duid = Int(DUID) else {
                reportWarning(message: "invalid DUID")
                return
            }
            let newPerson = DukePerson(
                DUID: duid,
                netID: netID,
                fName: fName,
                lName: lName,
                from: from,
                hobby: hobby,
                languages: languages.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                moviegenre: moviegenre,
                gender: gender,
                role: role,
                program: program,
                plan: plan,
                team: team,
                picture: picture,
                email1: email1.isEmpty ? nil : email1
            )
            do{
                try dataManager.addPerson(newPerson)
            }catch{
                reportError(error: error)
                dataManager.errorMessage = "fail to add person: duplicate ID"
                presentationMode.wrappedValue.dismiss()
            }
        } else if mode == .edit, let person = person {
            let updatedPerson = person
            updatedPerson.fName = fName
            updatedPerson.lName = lName
            updatedPerson.from = from
            updatedPerson.hobby = hobby
            updatedPerson.languages = languages.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            updatedPerson.moviegenre = moviegenre
            updatedPerson.gender = gender
            updatedPerson.role = role
            updatedPerson.program = program
            updatedPerson.plan = plan
            updatedPerson.team = team
            updatedPerson.picture = picture
            updatedPerson.email1 = email1.isEmpty ? nil : email1
            if !dataManager.updatePerson(updatedPerson)
            {
                reportError(error: ErrorWithCode(message: "Fail to Update person", code: ErrorCodeType.duplicateID))
                dataManager.errorMessage = "fail to update person: invalid ID"
                presentationMode.wrappedValue.dismiss()
            }
            if uploadToServer {
                print("upload")
                Task {
                    await dataManager.updateCurrentUser(newPerson: updatedPerson)
                }
            }
        }
        presentationMode.wrappedValue.dismiss()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst().lowercased()
    }
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}



//#Preview {
//    AddEditView()
//}

