//
//  HomePresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import Foundation

class HomePresenter: HomeContract.homePresenter {
    
    var homeView: HomeContract.homeView!
    
    var homeInteractor: HomeContract.homeInteractor!
    
    var homeRouter: HomeContract.homeRouter!
    
}

// MARK: - SELF RELATED METHODS
extension HomePresenter {
    
    func prepareAppointmentsTableViewData(_ appointmentsResponse: [Appointment]) -> [Appointment] {
        return [Appointment]()
    }
    
}

// MARK: - VIEW RELATED METHODS
extension HomePresenter {
    
    func viewWillAppear() {
        return
    }
    
    func displayPlaceholderOrTableView() {
        return
    }
    
    func deleteAppointment(with appointmentID: Int, in appointments: [AppointmentType]) {
        return
    }
    
}

// MARK: - INTERACTOR RELATED METHODS
extension HomePresenter {
    
    func didFetchAppointmentsResponse() {
        return
    }
    
    func didUpdateAppointments() {
        return
    }
    
}
