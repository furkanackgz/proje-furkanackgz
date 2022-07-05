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
        return
    }
    
}
