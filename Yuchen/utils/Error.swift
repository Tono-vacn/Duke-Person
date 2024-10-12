//
//  Error.swift
//  Yuchen
//
//  Created by Fall2024 on 9/14/24.
//

import Foundation

enum ErrorCodeType:Int {
    case InValidFileURL = 0
    case failToSave = 1
    case noValidCredential = 2
    case invalidURL = 3
    case failToParseAuthString = 4
    case serverError = 5
    case duplicateID = 6
    case unKnown = 7
}

enum FileSaveError: Error {
    case invalidNetID
    case netIDAlreadyExist
    case DUIDAlreadyExist
}

struct ErrorWithCode: Error {
    let message: String
    let code: ErrorCodeType
}

func reportError(error: Error) {
    print("Error: \(error)")
    print(error.localizedDescription)
}

func reportWarning(message: String){
    print("Warning:\(message)")
}

func reportMessage(message: String){
    print("Message:\(message)")
}
