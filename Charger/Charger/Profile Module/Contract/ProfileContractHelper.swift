//
//  ProfileContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import UIKit

extension ProfileContract {
    
    /**
     This is the function where we bind all layers of profile module together
     and send it back to where it is called. Without this binding VIPER design
     pattern would not work.
    */
    static func instantiateProfileModule() -> UIViewController? {
        
        if let profileView = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileView") as? ProfileView {
            
            // Profile Module Related Initializations
            let profileInteractor = ProfileInteractor()
            let profilePresenter = ProfilePresenter()
            let profileRouter = ProfileRouter()
            
            // View - Presenter Binding
            profileView.profilePresenter = profilePresenter
            profilePresenter.profileView = profileView
            
            // Interactor - Presenter Binding
            profileInteractor.profilePresenter = profilePresenter
            profilePresenter.profileInteractor = profileInteractor
            
            // Presenter - Router Binding
            profilePresenter.profileRouter = profileRouter
            
            return profileView
        }
        
        return nil
    }
    
}


