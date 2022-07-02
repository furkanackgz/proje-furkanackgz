//
//  LoginRequest.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 2.07.2022.
//

import Foundation

struct LoginRequest: Encodable {
    var email: String?
    var deviceUDID: String?
}
