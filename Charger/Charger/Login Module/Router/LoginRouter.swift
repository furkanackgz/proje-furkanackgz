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
        
        // Create navigation controller for home view
        let nvc = UINavigationController(rootViewController: homeView)
        
        // Present navigation controller modally
        nvc.modalPresentationStyle = .overFullScreen
        loginView.present(nvc, animated: true)
        
    }
    
}
