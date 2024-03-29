//
//  LoginResponse.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 2.07.2022.
//

import Foundation

struct LoginResponse: Decodable {
    var email: String?
    var token: String?
    var userID: Int?
}
