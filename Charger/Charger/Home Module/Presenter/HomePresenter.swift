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
        
        // Sort current appointments depending on their dates and times
        let currentAppointments = appointments.first?.appointments
        appointments.first?.appointments = sort(currentAppointments!)
        
        // Sort previous appointments depending on their dates and times
        let previousAppointments = appointments.last?.appointments
        appointments.last?.appointments = sort(previousAppointments!)
        
        // return prepared array
        return appointments
    }
    
    /**
     Sort function sorts appointments array given as the
     parameter and in its body it sorts the array by only
     appointment's time value and then it sends sorted by
     time appointments to the sortByDate method and takes
     its return value and sends this sorted by both time
     and date appointments array back to where it's called.
     
     -parameter appointments: Appointment typed array.
     -returns: Sorted by time and date Appointment typed array.
     */
    private func sort(_ appointments: [Appointment]) -> [Appointment] {
        
        // Sort appointments by time
        let sortedByTime = appointments.sorted(by: {
            $0.time!.compare($1.time!) == .orderedAscending
        })
        
        // Send sorted by time appointments to sortByDate method
        let sortedByTimeAndDate = sortByDate(sortedByTime)
        
        // Return sorted appointments by both time and date array
        return sortedByTimeAndDate
        
    }
    
    /**
     SortByDate function sorts appointments array given as the
     parameter and in its body it sorts the array by appointment's
     date value and sends it back to where it's called.
     
     -parameter sortedByTime: Appointments type array which is
     already sorted by their time values.
     -returns: Sorted by time and date Appointment typed array.
     */
    private func sortByDate(_ sortedByTime: [Appointment]) -> [Appointment] {
        
        // Sort appointments by date
        let sortedByTimeAndDate = sortedByTime.sorted(by: {
            $0.date!.compare($1.date!) == .orderedAscending
        })
        
        // Return sorted appointments by both time and date array
        return sortedByTimeAndDate
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
        
        // Check if Appointments array empty
        if homeView.isAppointmentsEmpty {
            // Appointments array is empty
            homeView.displayPlaceholderView()
        } else {
            // Appointments array is not empty
            homeView.displayTableView()
        }
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
