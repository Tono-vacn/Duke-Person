//
//  DataManager.swift
//  Yuchen
//
//  Created by Fall2024 on 9/26/24.
//

import Foundation
import SwiftData

class DataManager:NSObject, ObservableObject, URLSessionDataDelegate {
    private var modelContext: ModelContext
    
    @Published var downloadProgress: Double = 0.0
    @Published var isDownloading: Bool = false
    @Published var successMessage: String? = nil
    @Published var errorMessage: String? = nil
    @Published var showTab: Bool = true
    
    private var dataTask: URLSessionDataTask?
    private var expectedContentLength = 1
    private var buffer = Data()
    private var currentUpdateStrategy: DownloadTypeOption = .downloadAndUpdate
    
    let initData: DukePerson = DukePerson(DUID: 1281071, netID: "yj210", fName: "Yuchen", lName: "Jiang", from: "China", hobby: "cycling", languages: ["CHinese", "English"], moviegenre: "Fiction", gender: .Male, role: .Student, program: .MS, plan: .ECE, team: "None", picture: "", email1: "yuchen.jiang@duke.edu")
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let request = FetchDescriptor<DukePerson>()
        do{
            let persons = try modelContext.fetch(request)
            if persons.isEmpty{
                self.modelContext.insert(initData)
            }
        }catch{
            reportError(error: error)
        }
    }
//    override init(){
//        super.init()
//    }
//    func initContext(modelContext: ModelContext) {
//        self.modelContext = modelContext
//    }
    
    private func isStoreEmpty() -> Bool {
        let request = FetchDescriptor<DukePerson>()
        do{
            let persons = try modelContext.fetch(request)
            return persons.isEmpty
        }catch{
            reportError(error: error)
            self.errorMessage = "Swift Message Initilization Failed"
            return true
        }
    }
    
    func addPerson(_ person: DukePerson) throws {
        let personNetID = person.netID
        let fetchDescriptor = FetchDescriptor<DukePerson>(predicate: #Predicate { $0.netID == personNetID })
        if let _ = try? self.modelContext.fetch(fetchDescriptor).first {
            throw FileSaveError.netIDAlreadyExist
        }
        self.modelContext.insert(person)
    }
    
    func updatePerson(_ person: DukePerson) -> Bool {
        let personNetID = person.netID
        let fetchDescriptor = FetchDescriptor<DukePerson>(predicate: #Predicate { $0.netID == personNetID })
        if let existingPerson = try? self.modelContext.fetch(fetchDescriptor).first {
            existingPerson.DUID = person.DUID
            existingPerson.fName = person.fName
            existingPerson.lName = person.lName
            existingPerson.email1 = person.email1
            existingPerson.from = person.from
            existingPerson.gender = person.gender
            existingPerson.hobby = person.hobby
            existingPerson.languages = person.languages
            existingPerson.moviegenre = person.moviegenre
            existingPerson.role = person.role
            existingPerson.plan = person.plan
            existingPerson.program = person.program
            existingPerson.team = person.team
            existingPerson.picture = person.picture

            return true
        } else {
            return false
        }
    }
    
    func deletePerson(_ person: DukePerson) {
        self.modelContext.delete(person)
    }
    
    func deleteAll() -> Bool {
        let fetchedRequest = FetchDescriptor<DukePerson>()
        do{
            let results = try self.modelContext.fetch(fetchedRequest)
            for person in results {
                self.modelContext.delete(person)
            }
            try self.modelContext.save()
            return true
        }catch{
            reportError(error: error)
            self.errorMessage = "fail to remove all existing records"
            return false
        }
    }
    
    func insertNewPerson(newPersons: [DukePerson]){
        for person in newPersons {
            self.modelContext.insert(person)
        }
    }
    
    func replacePersons(newPersons: [DukePerson]) -> Bool{
        let res = self.deleteAll()
        if !res {
            return false
        }
        insertNewPerson(newPersons: newPersons)
        return true
    }
    
    func updateCurrentUser(newPerson: DukePerson) async {
        guard let url = URL(string: "\(DefaultUrl)\(generateUplodaEndpoint(netID: getNetID()))") else {
            reportError(error: ErrorWithCode(message: "invalid URL", code: ErrorCodeType.invalidURL))
            DispatchQueue.main.async {
                self.errorMessage = "Fail to parse server url"
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let authString = getUsernameAndPassword() else {
            reportError(error: ErrorWithCode(message: "no valid auth string", code: ErrorCodeType.noValidCredential))
            DispatchQueue.main.async {
                self.errorMessage = "login status expired"
            }
            return
        }
        let loginData = authString.data(using: .utf8)?.base64EncodedString() ?? ""
        request.setValue("Basic \(loginData)", forHTTPHeaderField: "Authorization")
        
        let toUpdateDTO = DukePersonDTO(netID: newPerson.netID, DUID: newPerson.DUID, fName: newPerson.fName, lName: newPerson.lName, from: newPerson.from, hobby: newPerson.hobby, languages: newPerson.languages, moviegenre: newPerson.moviegenre, gender: newPerson.gender, role: newPerson.role, program: newPerson.program, plan: newPerson.plan, team: newPerson.team, picture: newPerson.picture)
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(toUpdateDTO)
            request.httpBody = jsonData
        } catch {
            reportError(error: error)
            DispatchQueue.main.async {
                self.errorMessage = "fail to parse data"
            }
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    // print("update succeeded")
                    // 如果需要，可以在这里更新本地数据或通知用户
                    reportMessage(message: "update succeeded")
                    DispatchQueue.main.async {
                        self.successMessage = "Updated Successfully"
                    }
                } else {
                    // 服务器返回错误
                    let serverError = String(data: data, encoding: .utf8) ?? "Unknown Server Error"
                    reportError(error: ErrorWithCode(message: "ServerCode \(httpResponse.statusCode): \(serverError)", code: ErrorCodeType.serverError))
                    DispatchQueue.main.async {
                        self.successMessage = "Server Error: \(httpResponse.statusCode)"
                    }
                }
            }
        } catch {
            // 网络或其他错误
            reportError(error: error)
        }
    }
    
    func fetchPersonData(endPoint: String = DefaultUrl + AllEndPoint, strategy: DownloadTypeOption = .downloadAndReplace) async {
        guard let url = URL(string: endPoint) else {
            reportError(error: ErrorWithCode(message:"Invalid URL", code: ErrorCodeType.invalidURL))
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            return
        }
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let authstring = getUsernameAndPassword() else{
            reportError(error: ErrorWithCode(message:"no valid credential", code: ErrorCodeType.noValidCredential))
            DispatchQueue.main.async {
                self.errorMessage = "login status expired"
            }
            return
        }
        let loginData = "\(authstring)"
        request.setValue("Basic \(loginData.data(using: String.Encoding.utf8)!.base64EncodedString())", forHTTPHeaderField: "Authorization")
        
        dataTask = session.dataTask(with: request)
        DispatchQueue.main.async {
            self.isDownloading = true
            self.downloadProgress = 0.0
            self.currentUpdateStrategy = strategy
        }
        dataTask?.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        expectedContentLength = Int(response.expectedContentLength)
        buffer = Data()
        DispatchQueue.main.async {
            self.downloadProgress = 0.0
        }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer.append(data)
        let progress = Double(buffer.count) / Double(expectedContentLength)
        DispatchQueue.main.async {
            self.downloadProgress = progress
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            reportError(error: error)
            DispatchQueue.main.async {
                self.isDownloading = false
                self.errorMessage = "Downloading error"
            }
        }
        else {
            // 处理数据
            do {
                let fetchedPersons = try JSONDecoder().decode([DukePersonDTO].self, from: buffer)
                let newPersons = fetchedPersons.map{
                    personDTO in DukePerson(DTO: personDTO)
                }
                DispatchQueue.main.async {
                    switch self.currentUpdateStrategy {
                    case .downloadAndReplace:
                        let _ = self.replacePersons(newPersons: newPersons)
                        self.isDownloading = false
                        self.downloadProgress = 0.0
                    case .downloadAndUpdate:
                        for curPerson in newPersons {

                            if self.updatePerson(curPerson) {
                                continue
                            } else {
                                // 插入新人员
                                self.modelContext.insert(curPerson)
                            }
                            
                        }
                        self.isDownloading = false
                        self.downloadProgress = 0.0
                    case .cancel:
                        break
                    }
                }
            } catch {
                reportError(error: error)
                DispatchQueue.main.async {
                    self.isDownloading = false
                    self.errorMessage = "Fail to decode download data"
                }
            }
        }
    }
}
