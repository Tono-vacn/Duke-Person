//
//  authentication.swift
//  Yuchen
//
//  Created by Fall2024 on 9/22/24.
//

import Foundation

func getUsernameAndPassword() -> String? {
    if let authString = UserDefaults.standard.string(forKey: "AuthString") {
        return authString
    }
    return nil
}

func getSeperateNetIDAndPassword() -> (NetID: String?, password: String?) {
    if let authString = UserDefaults.standard.string(forKey: "AuthString") {
        let components = authString.components(separatedBy: ":")
        if components.count == 2 {
            let NetID = components[0]
            let password = components[1]
            return (NetID, password)
        }
    }
    return (nil, nil)
}


func getNetID() -> String {
    if let authString = UserDefaults.standard.string(forKey: "AuthString") {
        let components = authString.components(separatedBy: ":")
        if components.count == 2 {
            let NetID = components[0]
//            let password = components[1]
            return NetID
        }
    }
    reportError(error: ErrorWithCode(message: "fail to parse the authstring", code: .failToParseAuthString))
    return ""
}
