//
//  utils.swift
//  Yuchen
//
//  Created by Fall2024 on 9/26/24.
//

import Foundation

import SwiftUI

func decodeBase64ToImage(base64String: String) -> UIImage? {
    guard let imageData = Data(base64Encoded: base64String) else{
        return nil
    }
    return UIImage(data: imageData)
}
