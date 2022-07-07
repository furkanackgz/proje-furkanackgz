//
//  HomeEntity.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import Foundation

class HomeEntity: HomeContract.homeEntity {
    
    var decodedAppointmentsResponse: [Appointment]?
    
    var homeInteractor: HomeContract.homeInteractor?
    
}

// MARK: - SELF RELATED METHODS
extension HomeEntity {
    
    func decodeAppointments(response: Data) {
        
        // Decode response data to appointments response object
        do {
            decodedAppointmentsResponse = try JSONDecoder().decode([Appointment].self, from: response)
            
            // If there is no error occured while decoding, call interactor
            homeInteractor?.didDecodeAppointmentsResponse()
        } catch let error {
            print(error)
        }
        
    }
    
}
