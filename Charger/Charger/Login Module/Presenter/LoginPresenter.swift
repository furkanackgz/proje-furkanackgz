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
    
    func didUserPressGirisYapButton(with email: String, and deviceUDID: String) {
        /*
         If email address is valid, send login request with email
         and deviceUDID received. Otherwise, show alert to the user
         notifying that email address format is not valid.
        */
        if email.isValidEmail() {
            loginInteractor?.sendLoginRequest(email, deviceUDID)
        } else {
            loginView?.showAlert(title: "Hata",
                                 message: "Lütfen geçerli bir e-posta adresi giriniz")
        }
    }
    
}

// MARK: - INTERACTOR RELATED METHODS
extension LoginPresenter {
    
    func didLoginResponseReceived(_ loginResponse: LoginResponse) {
        return
    }
    
}
