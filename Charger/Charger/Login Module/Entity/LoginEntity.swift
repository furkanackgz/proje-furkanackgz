//
//  LoginEntity.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import Foundation

class LoginEntity: LoginContract.loginEntity {
    
    var encodedLoginRequest: LoginRequest?
    
    var decodedLoginResponse: LoginResponse?

    var loginInteractor: LoginContract.loginInteractor?
    
}

// MARK: - SELF RELATED METHODS
extension LoginEntity {
    
    func encodeLoginRequest(_ email: String, _ deviceUDID: String) {
        return
    }
    
    func decodeLoginResponse(_ data: Data) {
        return
    }
    
}
