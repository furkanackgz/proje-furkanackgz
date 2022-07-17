//
//  HomeInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import Foundation

class HomeInteractor: HomeContract.homeInteractor {
    
    var appointmentsResponse: [Appointment]?
    
    var homePresenter: HomeContract.homePresenter?
    
    var homeEntity: HomeContract.homeEntity!
    
}

// MARK: - SELF RELATED METHODS
extension HomeInteractor {
    
    // Connect to web service and fetch appointments
    // response data
    func fetchAppointmentsResponse() {
        HomeService.run.sendAppointmentsRequest { [weak self] data in
            // If data received from server as a response
            // send it to entity layer for decoding purpose
            if let data = data {
                self?.homeEntity.decodeAppointments(response: data)
            }
        }
    }
    
}

// MARK: - PRESENTER RELATED METHODS
extension HomeInteractor {
    
    func didDecodeAppointmentsResponse() {
        
        // Take decoded appointments response array from entity layer
        guard let appointmentsResponse = homeEntity.decodedAppointmentsResponse else { return }
        
        // Assign it to appointments response property
        self.appointmentsResponse = appointmentsResponse
        
        // Notify presenter that appointments response fetched
        homePresenter?.didFetchAppointmentsResponse()
    }
    
    func deleteAppointment(with appointmentID: Int) {
        
        /**
         Send delete appointment request to the home service with
         the received appointment id and return succeed information
         with the completion handler about whether appointment could
         be deleted.
         
         parameter appointmentID: Appointment id of the particular
         cell that wished to be deleted by the user.
         returns: none
         */
        HomeService.run.sendDeleteAppointmentRequest(with: appointmentID) { [weak self] succeed in
            
            if succeed {
                self?.homePresenter?.didDeleteAppointment()
            } else {
                // Show alert to notify user that appointment
                // cannot be deleted
            }
            
        }
        
    }
    
}
