//
//  PickDateAndTimeInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import Foundation

class PickDateAndTimeInteractor: PickDateAndTimeContract.pickDateAndTimeInteractor {
    
    // MARK: - Properties
    var stationInfo: StationInfo?
    
    var appointmentRequest: AppointmentRequest?
    
    var stationID: Int?
    
    var date: String?
    
    var pickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter?
    
    var pickDateAndTimeEntity: PickDateAndTimeContract.pickDateAndTimeEntity!
    
}

// Self related
extension PickDateAndTimeInteractor {
    
    // MARK: - fetchStationInfo
    func fetchStationInfo(with stationID: Int, and date: String) {
        
        PickDateAndTimeService.run.sendStationInfoRequest(with: self.stationID!,
                                                          and: self.date!) { [weak self] data in
            
            // If data is received then send it to entity layer for decoding
            if let data = data {
                self?.pickDateAndTimeEntity.decodeStationInfoResponse(data)
            }
            
        }
        
    }
    
    // MARK: - setAppointmentRequest
    func setAppointmentRequest(with appointmentRequest: AppointmentRequest) {
        
        // Set appointment request came from parameter to class appointment request
        self.appointmentRequest = appointmentRequest
        
    }
    
}

// Entity related
extension PickDateAndTimeInteractor {
    
    // MARK: - didDecodeStationInfo
    func didDecodeStationInfo() {
        
        // Take the decoded station info
        guard let stationInfo = pickDateAndTimeEntity.decodedStationInfo else { return }
        
        // Assign station info in this class
        self.stationInfo = stationInfo
        
        // Call did fetch station info method in presenter
        pickDateAndTimePresenter?.didFetchStationInfo()
        
    }
    
}
