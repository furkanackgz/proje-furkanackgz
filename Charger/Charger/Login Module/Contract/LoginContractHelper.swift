//
//  LoginContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import UIKit

extension LoginContract {
    
    /**
     This is the function where we bind all layers of login module together
     and send it back to where it is called. Without this binding VIPER design
     pattern would not work.
     */
    static func instantiateLoginModule() -> UIViewController? {
        
        if let loginView = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginView") as? LoginView {
            
            // Login Module Related Initializations
            let loginInteractor = LoginInteractor()
            let loginPresenter = LoginPresenter()
            let loginEntity = LoginEntity()
            let loginRouter = LoginRouter()
            
            // View - Presenter Binding
            loginView.loginPresenter = loginPresenter
            loginPresenter.loginView = loginView
            
            // Interactor - Presenter Binding
            loginInteractor.loginPresenter = loginPresenter
            loginPresenter.loginInteractor = loginInteractor
            
            // Router - Presenter Binding
            loginRouter.loginPresenter = loginPresenter
            loginPresenter.loginRouter = loginRouter
            
            // Interactor - Entity Binding
            loginInteractor.loginEntity = loginEntity
            loginEntity.loginInteractor = loginInteractor
            
            // Router - View Binding
            loginRouter.loginView = loginView
            
            return loginView
        }
        
        return nil
    }
    
}

