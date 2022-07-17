//
//  AppointmentDetailsEntity.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import Foundation

class AppointmentDetailsEntity: AppointmentDetailsContract.appointmentDetailsEntity {
    
    // MARK: - Properties
    var encodedAppointmentRequest: Data?
    
    var appointmentDetailsInteractor: AppointmentDetailsContract.appointmentDetailsInteractor?
    
}

// Self related
extension AppointmentDetailsEntity {
    
    // MARK: - encodeAppointmentRequest
    func encodeAppointmentRequest(_ appointmentRequest: AppointmentRequest) {
        
        do {
            // Encode to data object
            encodedAppointmentRequest = try JSONEncoder().encode(appointmentRequest)
            
            // If there is no error while encoding it call interactor
            appointmentDetailsInteractor?.didEncodeAppointmentRequest()
            
        } catch let error {
            print(error)
        }
        
    }
    
}
