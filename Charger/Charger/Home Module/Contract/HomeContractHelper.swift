//
//  HomeContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import UIKit

extension HomeContract {
    
    /**
     This is the function where we bind all layers of login module together
     and send it back to where it is called. Without this binding VIPER design
     pattern would not work.
    */
    static func instantiateHomeModule() -> UIViewController? {
        
        if let homeView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeView {
            
            // Home Module Related Initializations
            let homeInteractor = HomeInteractor()
            let homePresenter = HomePresenter()
            let homeEntity = HomeEntity()
            let homeRouter = HomeRouter()
            
            // View - Presenter Binding
            homeView.homePresenter = homePresenter
            homePresenter.homeView = homeView
            
            // Interactor - Presenter Binding
            homeInteractor.homePresenter = homePresenter
            homePresenter.homeInteractor = homeInteractor
            
            // Interactor - Entity Binding
            homeInteractor.homeEntity = homeEntity
            homeEntity.homeInteractor = homeInteractor
            
            // Router - View Binding
            homeRouter.homeView = homeView
            
            
            return homeView
        }
        
        return nil
    }
    
}
