//
//  AppointmentDetailsInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import Foundation

class AppointmentDetailsInteractor: AppointmentDetailsContract.appointmentDetailsInteractor {
    
    // MARK: - Properties
    var stationInfo: StationInfo?
    
    var appointmentRequest: AppointmentRequest?
    
    var appointmentDetailsPresenter: AppointmentDetailsContract.appointmentDetailsPresenter?
    
    var appointmentDetailsEntity: AppointmentDetailsContract.appointmentDetailsEntity!
    
}

// Self related
extension AppointmentDetailsInteractor {
    
    // MARK: - sendAppointmentRequest
    func sendAppointmentRequest() {
     
        // Unwrap appointment request
        guard let appointmentRequest = appointmentRequest else { return }
        
        // Call entity layer to encode appointment request
        appointmentDetailsEntity.encodeAppointmentRequest(appointmentRequest)
        
    }
    
}

// Entity related
extension AppointmentDetailsInteractor {
    
    // MARK: - didEncodeAppointmentRequest
    func didEncodeAppointmentRequest() {
        
        // Take encoded appointment request from entity layer
        guard let appointmentRequest = appointmentDetailsEntity.encodedAppointmentRequest else { return }
        
        // Call send appointment request in service layer with the
        // encoded appointment requst
        AppointmentDetailsService.run.sendAppointmentRequest(with: appointmentRequest) { [weak self] success in
            
            // If appointment request is completed
            // succesfully, let presenter know
            if success {
                
                self?.appointmentDetailsPresenter?.didSendAppointmentRequest()
                
            }
            
        }
        
    }
    
}
