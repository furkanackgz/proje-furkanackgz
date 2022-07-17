//
//  LoginRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import UIKit

class LoginRouter: LoginContract.loginRouter {
    
    var loginView: LoginContract.loginView!
    
    var loginPresenter: LoginContract.loginPresenter!
    
}

// MARK: - SELF RELATED METHODS
extension LoginRouter {
    
    func navigateToHomePage(_ loginView: LoginView) {
        
        // Instantiate home view
        guard let homeView = HomeContract.instantiateHomeModule() else { return }
        
        // Push home view onto login view
        loginView.navigationController?.pushViewController(homeView, animated: true)
        
    }
    
}
