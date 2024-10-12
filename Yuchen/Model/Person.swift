//
//  Person.swift
//  Yuchen
//
//  Created by Fall2024 on 9/26/24.
//

import Foundation

import SwiftData

struct DukePersonDTO: Codable {
    var netID: String
    var DUID: Int
    var fName: String
    var lName: String
    var from: String // Where are you from
    var hobby: String // Your favorite pastime / hobby
    var languages: [String] // Up to 3 PROGRAMMING languages that you know.
    var moviegenre: String // Your favorite movie genre (Thriller, Horror, RomCom, etc)
    var gender: Gender
    var role: Role
    var program: Program
    var plan: Plan
    var team: String
    var picture: String
    var email1: String? // Comes from the server– you can change to your preferred email.
}

@Model
final class DukePerson: CustomStringConvertible, Identifiable {
    var id: String {netID} // only for Identifiable, same as netID
    
    @Attribute(.unique)
    var DUID: Int
    
    @Attribute(.unique)
    var netID: String
    
    var fName: String
    var lName: String
    var from: String // Where are you from
    var hobby: String // Your favorite pastime / hobby
    var languages: [String] // Up to 3 PROGRAMMING languages that you know.
    var moviegenre: String // Your favorite movie genre (Thriller, Horror, RomCom, etc)
    var gender: Gender
    var role: Role
    var program: Program
    var plan: Plan
    var team: String
    var picture: String
    var email1: String? // Comes from the server– you can change to your preferred email.
    
    @Transient
    var email2: String {
        return "\(netID).duke.edu"
    }// This is computed from netid. This is your standard Duke email.
    
    @Transient
    var description: String {
        let pronoun = (gender == .Male) ?  "He" : ((gender == .Female) ? "She" : "They")
        let beVal = pronoun == "They" ? "are" : "is"
        let objective = (gender == .Male) ?  "him" : ((gender == .Female) ? "her" : "them")
        let roleVal = (role == .Student || role == .Student) ? "Student" :  ((role == .Professor) ? "Professor" : "Other")
        var emailString: String
        if let email1 = email1 {
                emailString = email1 + " or " + email2
        }else{
            emailString = email2
        }
        let tail = (role == .Student || role == .TA) ? "\(fName) is in the \(program) studying \(plan)." : ""
        return "\(fName) \(lName) is a \(roleVal). \(pronoun) \(beVal) from \(from) and enjoys \(hobby). \(fName) likes to watch \(moviegenre) movies and \(beVal) proficient in \(languages.joined(separator: " ,")). You can reach \(objective) at \(emailString). \(tail)"
        }
    
    init(DUID: Int, netID: String, fName: String, lName: String, from: String, hobby: String, languages: [String], moviegenre: String, gender: Gender, role: Role, program: Program, plan: Plan, team: String, picture: String, email1: String? = nil) {
        self.DUID = DUID
        self.netID = netID
        self.fName = fName
        self.lName = lName
        self.from = from
        self.hobby = hobby
        self.languages = languages
        self.moviegenre = moviegenre
        self.gender = gender
        self.role = role
        self.program = program
        self.plan = plan
        self.team = team
        self.picture = picture
        self.email1 = email1
    }
    
    init(DTO: DukePersonDTO){
        self.DUID = DTO.DUID
        self.netID = DTO.netID
        self.fName = DTO.fName
        self.lName = DTO.lName
        self.from = DTO.from
        self.hobby = DTO.hobby
        self.languages = DTO.languages
        self.moviegenre = DTO.moviegenre
        self.gender = DTO.gender
        self.role = DTO.role
        self.program = DTO.program
        self.plan = DTO.plan
        self.team = DTO.team
        self.picture = DTO.picture
        self.email1 = DTO.email1
    }
    
}
