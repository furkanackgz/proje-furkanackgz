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
    
    func prepareAppointmentsTableViewData(_ appointmentsResponse: [Appointment]) -> [AppointmentType] {
        
        // Create the array which will be shown in appointments table view
        let appointments: [AppointmentType] = [
            .init(name: "Güncel Randevular", appointments: [Appointment]()),
            .init(name: "Geçmiş Randevular", appointments: [Appointment]())
        ]
        
        appointmentsResponse.forEach { appointment in
            
            // Unwrap hasPassed value of appointment
            if let hasPassed = appointment.hasPassed {
                
                // If appointment's date is not passed
                if !hasPassed {
                    // Assign it to appointments array in Güncel Randevular
                    appointments.first?.appointments.append(appointment)
                } else {
                    // Assign it to appointments array in Geçmiş Randevular
                    appointments.last?.appointments.append(appointment)
                }
                
            }
            
        }
        
        // return prepared array
        return appointments
    }
    
}

// MARK: - VIEW RELATED METHODS
extension HomePresenter {
    
    func viewDidLoad() {
        return
    }
    
    // Call fetch appointments response method in
    // interactor layer
    func viewWillAppear() {
        homeInteractor.fetchAppointmentsResponse()
    }
    
    func didPressProfileBarButton() {
        return
    }
    
    func didPressRandevuOlusturButton() {
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
        
        // Take appointments response from interactor layer
        guard let appointmentsResponse = homeInteractor.appointmentsResponse else { return }
        
        // Prepare it to the right format for table view
        let appointments = prepareAppointmentsTableViewData(appointmentsResponse)
        
        // Send it to home view layer for displaying in main queue
        DispatchQueue.main.async { [weak self] in
            self?.homeView.updateAppointmentsTableView(with: appointments)
        }
       
    }
    
    func didUpdateAppointments() {
        return
    }
    
}
