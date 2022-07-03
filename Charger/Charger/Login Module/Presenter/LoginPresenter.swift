//
//  LoginPresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import Foundation

class LoginPresenter: LoginContract.loginPresenter {
    
    var loginView: LoginContract.loginView?
    
    var loginInteractor: LoginContract.loginInteractor?

    var loginRouter: LoginContract.loginRouter?
    
}

// MARK: - VIEW RELATED METHODS
extension LoginPresenter {
    
    func didUserPressGirisYapButton(with email: String) {
        return
    }
    
}

// MARK: - INTERACTOR RELATED METHODS
extension LoginPresenter {
    
    func didLoginResponseReceived(_ loginResponse: LoginResponse) {
        return
    }
    
}
