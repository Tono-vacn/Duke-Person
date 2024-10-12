//
//  CommuneParam.swift
//  Yuchen
//
//  Created by Fall2024 on 9/6/24.
//

import Foundation

let DefaultUrl = "http://ece564.rc.duke.edu:8080/"

let AllEndPoint = "entries/all"

func generateUplodaEndpoint(netID: String) -> String {
    return "entries/\(netID)"
}
