//
//  StationSearchContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 13.07.2022.
//

import UIKit

extension StationSearchContract {
    
    /**
     This is the function where we bind all layers of station search module
     together and send it back to where it is called. Without this binding
     VIPER design pattern would not work.
     
     parameter province: Province name that the stations in that province
     will be displayed in table view.
     returns: View layer of station search module.
    */
    static func instantiateStationSearchModule(with province: String, and  homeView: HomeView) -> UIViewController? {
        
        if let stationSearchView = UIStoryboard(name: "StationSearch", bundle: nil).instantiateViewController(withIdentifier: "StationSearchView") as? StationSearchView {
            
            // Assign province to station search view
            stationSearchView.province = province
            
            // Station search module related initializations
            let stationSearchInteractor = StationSearchInteractor()
            let stationSearchPresenter = StationSearchPresenter()
            let stationSearchEntity = StationSearchEntity()
            let stationSearchRouter = StationSearchRouter()
            
            // Assign home view to router layer
            stationSearchRouter.homeView = homeView
            
            // View - Presenter Binding
            stationSearchView.stationSearchPresenter = stationSearchPresenter
            stationSearchPresenter.stationSearchView = stationSearchView
            
            // Interactor - Presenter Binding
            stationSearchInteractor.stationSearchPresenter = stationSearchPresenter
            stationSearchPresenter.stationSearchInteractor = stationSearchInteractor
            
            // Interactor - Entity Binding
            stationSearchInteractor.stationsSearchEntity = stationSearchEntity
            stationSearchEntity.stationSearchInteractor = stationSearchInteractor
            
            // Presenter - Router Binding
            stationSearchPresenter.stationSearchRouter = stationSearchRouter
            
            
            return stationSearchView
        }
        
        return nil
    }
    
}
