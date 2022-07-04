//
//  LoginEntity.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import Foundation

class LoginEntity: LoginContract.loginEntity {
    
    var encodedLoginRequest: Data?
    
    var decodedLoginResponse: LoginResponse?

    var loginInteractor: LoginContract.loginInteractor?
    
}

// MARK: - SELF RELATED METHODS
extension LoginEntity {
    
    func encodeLoginRequest(_ email: String, _ deviceUDID: String) {
        
        let loginRequest = LoginRequest(email: email,
                                        deviceUDID: deviceUDID)
        
        // Encode login request to data object
        do {
            encodedLoginRequest = try JSONEncoder().encode(loginRequest)
            
            // If there is no error occured while encoding, call interactor
            loginInteractor?.didEncodeLoginRequest()
        } catch let error {
            print(error)
        }
    }
    
    func decodeLoginResponse(_ data: Data) {
        return
    }
    
}
