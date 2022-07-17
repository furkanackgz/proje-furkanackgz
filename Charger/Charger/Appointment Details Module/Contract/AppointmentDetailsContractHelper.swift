//
//  AppointmentDetailsContractHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

extension AppointmentDetailsContract {
    
    /**
     This is the function where we bind all layers of appointment details
     module together and send it back to where it is called. Without this
     binding VIPER design pattern would not work.
     
     parameter stationInfo: Station info is the object that is used to fetch
     required information about station to display in appointment details
     table view.
     
     parameter appointmentRequest: Appointment request object will be used to
     make appointment request.
     
     returns: View layer of station search module.
    */
    static func instantiateAppointmentDetailsModule(_ stationInfo: StationInfo,
                                                    _ appointmentRequest: AppointmentRequest) -> UIViewController? {
        
        if let appointmentDetailsView = UIStoryboard(name: "AppointmentDetails", bundle: nil).instantiateViewController(withIdentifier: "AppointmentDetailsView") as? AppointmentDetailsView {
            
            // Appointment details related initializations
            let appointmentDetailsInteractor = AppointmentDetailsInteractor()
            let appointmentDetailsPresenter = AppointmentDetailsPresenter()
            let appointmentDetailsEntity = AppointmentDetailsEntity()
            let appointmentDetailsRouter = AppointmentDetailsRouter()
            
            // Assign station info and appointment request to interactor
            appointmentDetailsInteractor.stationInfo = stationInfo
            appointmentDetailsInteractor.appointmentRequest = appointmentRequest
            
            // View - Presenter Binding
            appointmentDetailsView.appointmentDetailsPresenter = appointmentDetailsPresenter
            appointmentDetailsPresenter.appointmentDetailsView = appointmentDetailsView
            
            // Interactor - Presenter Binding
            appointmentDetailsInteractor.appointmentDetailsPresenter = appointmentDetailsPresenter
            appointmentDetailsPresenter.appointmentDetailsInteractor = appointmentDetailsInteractor
            
            // Interactor - Entity Binding
            appointmentDetailsInteractor.appointmentDetailsEntity = appointmentDetailsEntity
            appointmentDetailsEntity.appointmentDetailsInteractor = appointmentDetailsInteractor
            
            // Presenter - Router Binding
            appointmentDetailsPresenter.appointmentDetailsRouter = appointmentDetailsRouter
            
            
            return appointmentDetailsView
        
        }
        
        return nil
    }
    
}
