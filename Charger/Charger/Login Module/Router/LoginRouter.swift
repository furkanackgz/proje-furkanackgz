//
//  LoginRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import Foundation

class LoginRouter: LoginContract.loginRouter {
    
    var loginView: LoginContract.loginView!
    
    var loginPresenter: LoginContract.loginPresenter!
    
}

// MARK: - SELF RELATED METHODS
extension LoginRouter {
    
    func navigateToHomePage(_ loginView: LoginView) {
        // Present home view modally
        
    }
    
}
