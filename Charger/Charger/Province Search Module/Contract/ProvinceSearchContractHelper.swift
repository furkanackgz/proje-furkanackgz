//
//  ProvinceSearchContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 11.07.2022.
//

import UIKit

extension ProvinceSearchContract {
    
    /**
     This is the function where we bind all layers of province search module
     together and send it back to where it is called. Without this binding
     VIPER design pattern would not work.
    */
    static func instantiateProvinceSearchModule() -> UIViewController? {
        
        if let provinceSearchView = UIStoryboard(name: "ProvinceSearch", bundle: nil).instantiateViewController(withIdentifier: "ProvinceSearchView") as? ProvinceSearchView {
            
            // Province search module related initializations
            let provinceSearchInteractor = ProvinceSearchInteractor()
            let provinceSearchPresenter = ProvinceSearchPresenter()
            let provinceSearchRouter = ProvinceSearchRouter()
            
            // View - Presenter Binding
            provinceSearchView.provinceSearchPresenter = provinceSearchPresenter
            provinceSearchPresenter.provinceSearchView = provinceSearchView
            
            // Interactor - Presenter Binding
            provinceSearchInteractor.provinceSearchPresenter = provinceSearchPresenter
            provinceSearchPresenter.provinceSearchInteractor = provinceSearchInteractor
            
            // Presenter - Router Binding
            provinceSearchPresenter.provinceSearchRouter = provinceSearchRouter
            
            return provinceSearchView
        }
        
        return nil
    }
    
}
