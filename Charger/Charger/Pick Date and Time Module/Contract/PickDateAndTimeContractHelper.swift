//
//  PickDateAndTimeContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import UIKit

extension PickDateAndTimeContract {
    
    /**
     This is the function where we bind all layers of pick date and time module
     together and send it back to where it is called. Without this binding
     VIPER design pattern would not work.
     
     parameter stationID: Station id that will be used to fetch station info
     about sockets.
     parameter date: Date object that will be used to fetch station info about
     sockets. Initially this date object points to today's date.
     returns: View layer of station search module.
    */
    static func instantiatePickDateAndTimeModule(with stationID: Int,
                                                 and date: String) -> UIViewController? {
        
        if let pickDateAndTimeView = UIStoryboard(name: "PickDateAndTime", bundle: nil).instantiateViewController(withIdentifier: "PickDateAndTimeView") as? PickDateAndTimeView {
            
            // Pick date and time module related initializations
            let pickDateAndTimeInteractor = PickDateAndTimeInteractor()
            let pickDateAndTimePresenter = PickDateAndTimePresenter()
            let pickDateAndTimeEntity = PickDateAndTimeEntity()
            let pickDateAndTimeRouter = PickDateAndTimeRouter()
            
            // Assign stationID and date parameters to interactor layer
            pickDateAndTimeInteractor.stationID = stationID
            pickDateAndTimeInteractor.date = date
            
            // View - Presenter Binding
            pickDateAndTimeView.pickDateAndTimePresenter = pickDateAndTimePresenter
            pickDateAndTimePresenter.pickDateAndTimeView = pickDateAndTimeView
            
            // Interactor - Presenter Binding
            pickDateAndTimeInteractor.pickDateAndTimePresenter = pickDateAndTimePresenter
            pickDateAndTimePresenter.pickDateAndTimeInteractor = pickDateAndTimeInteractor
            
            // Interactor - Entity Binding
            pickDateAndTimeInteractor.pickDateAndTimeEntity = pickDateAndTimeEntity
            pickDateAndTimeEntity.pickDateAndTimeInteractor = pickDateAndTimeInteractor
            
            // Presenter - Router Binding
            pickDateAndTimePresenter.pickDateAndTimeRouter = pickDateAndTimeRouter
            
            return pickDateAndTimeView
        }
        
        return nil
    }
    
}
