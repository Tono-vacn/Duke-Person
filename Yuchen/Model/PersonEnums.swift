//
//  PersonEnums.swift
//  Yuchen
//
//  Created by Fall2024 on 9/26/24.
//

import Foundation

enum Role : String, Codable, CaseIterable {
    case Unknown = "Unknown" // has not been specified
    case Professor = "Professor"
    case TA = "TA"
    case Student = "Student"
    case Other = "Other" // has been specified, but is not Professor, TA, or Student
}
enum Gender : String, Codable, CaseIterable {
    case Unknown = "Unknown" // has not been specified
    case Male = "Male"
    case Female = "Female"
    case Other = "Other" // has been specified, but is not “Male” or “Female”
}
enum Program : String, Codable, CaseIterable {
    case NotApplicable = "NA"
    case MENG = "MENG"
    case BA = "BA"
    case BS = "BS"
    case MS = "MS"
    case PHD = "PhD"
    case Other = "Other"
}
enum Plan: String, Codable, CaseIterable {
    case NotApplicable = "NA"
    case CS = "Computer Science"
    case ECE = "ECE"
    case FinTech = "FinTech"
    case Other = "Other"
}
