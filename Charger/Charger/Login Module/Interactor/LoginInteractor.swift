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
    
    func sendLoginRequest(_ email: String, _ deviceUDID: String) {
        return
    }
    
    func fetchLoginResponse() {
        return
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
