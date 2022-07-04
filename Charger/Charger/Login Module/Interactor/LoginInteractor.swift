//
//  LoginInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import Foundation

class LoginInteractor: LoginContract.loginInteractor {

    var loginPresenter: LoginContract.loginPresenter!
    
    var loginEntity: LoginContract.loginEntity!
    
}

// MARK: - SELF RELATED METHODS
extension LoginInteractor {
    /**
     Send email and deviceUDID information to entity layer
     for encoding them into loginRequest struct.
    */
    func sendLoginRequest(_ email: String, _ deviceUDID: String) {
        
        loginEntity.encodeLoginRequest(email, deviceUDID)
    }
    
    /**
     Send succesfully encoded data to service layer for
     interacting with the server.
     */
    func fetchLoginResponse() {
        
    }
    
}

// MARK: - ENTITY RELATED METHODS
extension LoginInteractor {
    
    func didEncodeLoginRequest() {
        return
    }
    
    func didDecodeLoginResponse() {
        return
    }
    
}
