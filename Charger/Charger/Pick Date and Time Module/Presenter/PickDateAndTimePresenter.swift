//
//  PickDateAndTimePresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import Foundation

class PickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter {
    
    // MARK: - Properties
    var pickDateAndTimeView: PickDateAndTimeContract.pickDateAndTimeView!
    
    var pickDateAndTimeInteractor: PickDateAndTimeContract.pickDateAndTimeInteractor!
    
    var pickDateAndTimeRouter: PickDateAndTimeContract.pickDateAndTimeRouter!
    
}

// View related
extension PickDateAndTimePresenter {
    
    // MARK: - viewDidLoad
    func viewDidLoad() {
        
        // Get station id came from station search module
        guard let stationID = pickDateAndTimeInteractor.stationID else { return }
        
        // Get today's date came from station search module
        guard let date = pickDateAndTimeInteractor.date else { return }
        
        // Call interactor to fetch station info data
        pickDateAndTimeInteractor.fetchStationInfo(with: stationID, and: date)
        
    }
    
    // MARK: - didSelectTimeSlot
    func didSelectTimeSlot(_ socketID: Int, _ timeSlot: String, _ appointmentDate: String) {
        
        // Take stationID property from station info property in interactor layer
        guard let stationID = pickDateAndTimeInteractor.stationInfo?.stationID else { return }
        
        // Create appointment request with the parameters
        let appointmentRequest = AppointmentRequest(stationID: stationID, socketID: socketID, timeSlot: timeSlot, appointmentDate: appointmentDate)
        
        // Send appointment request object to interactor layer
        pickDateAndTimeInteractor.setAppointmentRequest(with: appointmentRequest)
        
    }
    
    // MARK: - didPressDevamEtButton
    func didPressDevamEtButton(_ pickDateAndTimeView: PickDateAndTimeView) {
        
        // Take station info from interactor layer
        guard let stationInfo = pickDateAndTimeInteractor.stationInfo else { return }
        
        // Take appointment request object from interactor layer
        guard let appointmentRequest = pickDateAndTimeInteractor.appointmentRequest else { return }
        
        // Call navigate to appointment details page with the station info and
        // appointment request objects
        pickDateAndTimeRouter.navigateToAppointmentDetailsPage(pickDateAndTimeView,
                                                               stationInfo, appointmentRequest)
        
    }
    
}

// Interactor related
extension PickDateAndTimePresenter {
    
    // MARK: - didFetchStationInfo
    func didFetchStationInfo() {
        
        // Take station info from interactor layer
        guard let stationInfo = pickDateAndTimeInteractor.stationInfo else { return }
        
        // Take out the station name property inside station info
        guard let stationName = stationInfo.stationName else { return }
        
        // Take out sockets property inside station info and call set sockets method
        // in view layer
        guard let sockets = stationInfo.sockets else { return }
        
        // Call in main queue since current thread is global
        // due to fetching data from server
        DispatchQueue.main.async { [weak self] in
            
            // Assign station name to station name property in view layer
            self?.pickDateAndTimeView.stationName = stationName
            
            // Assign sockets to table views in view layer
            self?.pickDateAndTimeView.set(sockets: sockets)
            
        }
        
    }
    
}
