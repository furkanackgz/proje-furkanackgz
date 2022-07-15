//
//  FilteringContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 15.07.2022.
//

import UIKit

extension FilteringContract {
    
    /**
     This is the function where we bind all layers of filtering module
     together and send it back to where it is called. Without this binding
     VIPER design pattern would not work.
     
     parameter filterChoices: Previous filter choices if already set.
     returns: View layer of filtering module.
    */
    static func instantiateFilteringModule(with filterChoices: [Filter]) -> UIViewController? {
        
        if let filteringView = UIStoryboard(name: "Filtering", bundle: nil).instantiateViewController(withIdentifier: "FilteringView") as? FilteringView {
            
            // Filtering module related initializations
            let filteringInteractor = FilteringInteractor()
            let filteringPresenter = FilteringPresenter()
            let filteringRouter = FilteringRouter()
            
            // Assign filter choices to interactor
            filteringInteractor.filterChoices = filterChoices
            
            // View - Presenter Binding
            filteringView.filteringPresenter = filteringPresenter
            filteringPresenter.filteringView = filteringView
            
            // Presenter - Interactor Binding
            filteringPresenter.filteringInteractor = filteringInteractor
            
            // Presenter - Router Binding
            filteringPresenter.filteringRouter = filteringRouter
            
            return filteringView
        }
        
        return nil
    }
    
}
