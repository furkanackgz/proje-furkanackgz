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
    
    func fetchAppointmentsResponse() {
        return
    }
    
}

// MARK: - PRESENTER RELATED METHODS
extension HomeInteractor {
    
    func didDecodeAppointmentsResponse() {
        return
    }
    
    func updateAppointments(_ updatedAppointments: [Appointment]) {
        return
    }
    
}
