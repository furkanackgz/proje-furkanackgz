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
            
            // Set response data to defaults for later access
            setDeviceIDToDefaults(deviceUDID)
            
            // Call send login request method in interactor
            loginInteractor?.sendLoginRequest(email, deviceUDID)
            
        } else {
            loginView?.showAlert(title: "Hata",
                                 message: "Lütfen geçerli bir e-posta adresi giriniz")
        }
    }
    
}

// MARK: - INTERACTOR RELATED METHODS
extension LoginPresenter {
    
    /**
     Save the received response data to user defaults for
     accessing easily any where we need in the project.
     And move into homepage of the application.
     
     parameter loginResponse: Received response from server.
     returns: none
     */
    func didLoginResponseReceived(_ loginResponse: LoginResponse) {
        // Set response data to defaults for later access
        setLoginResponseToDefaults(loginResponse)
        
        // Go to homepage with login router layer
        DispatchQueue.main.async { [unowned self] in
            loginRouter?.navigateToHomePage(loginView as! LoginView)
        }
    }
    
}

// MARK: - SELF RELATED METHODS
extension LoginPresenter {
    
    private func setLoginResponseToDefaults(_ loginResponse: LoginResponse) {
        // Helper
        let defaults = UserDefaults.standard
        
        // Set e-mail to user defaults
        if let email = loginResponse.email {
            defaults.set(email, forKey: "email")
        }
        
        // Set token to user defaults
        if let token = loginResponse.token {
            defaults.set(token, forKey: "token")
        }
        
        // Set userId to user defaults
        if let userID = loginResponse.userID {
            defaults.set(userID, forKey: "userID")
        }
    }
    
    private func setDeviceIDToDefaults(_ deviceUDID: String) {
        // Helper
        let defaults = UserDefaults.standard
        
        // Set deviceID to user defaults
        defaults.set(deviceUDID, forKey: "deviceID")
    }
}
