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
    
    // MARK: - prepareAppointmentsTableViewData
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
        // in ascending order
        let currentAppointments = appointments.first?.appointments
        appointments.first?.appointments = sort(currentAppointments!, in: "Ascending Order")
        
        // Sort previous appointments depending on their dates and times
        // in descending order
        let previousAppointments = appointments.last?.appointments
        appointments.last?.appointments = sort(previousAppointments!, in: "Descending Order")
        
        // return prepared array
        return appointments
    }
    
    // MARK: - sort
    /**
     Sort function sorts appointments array given as the
     parameter in order which is also given as a parameter,
     in its body it sorts the array by only appointment's
     time value and then it sends sorted by time appointments
     to the sortByDate method and takes its return value and
     sends this sorted by both time and date appointments array
     back to where it's called.
     
     -parameter appointments: Appointment typed array.
     -parameter order: Ascending or Descending Order in string.
     -returns: Sorted by time and date Appointment typed array
     in particular order.
     */
    private func sort(_ appointments: [Appointment],
                      in order: String) -> [Appointment] {
        
        var sortedByTimeAndDate: [Appointment]?
        
        // Sort appointments by time
        if order == "Ascending Order" {
            
            // In ascending order
            let sortedByTime = appointments.sorted(by: {
                $0.time!.compare($1.time!) == .orderedAscending
            })
            
            // Send sorted by time in ascending order appointments
            // to sortByDate method
            sortedByTimeAndDate = sortByDate(sortedByTime, in: "Ascending Order")
            
        } else if order == "Descending Order" {
            
            // In descending order
            let sortedByTime = appointments.sorted(by: {
                $0.time!.compare($1.time!) == .orderedDescending
            })
            
            // Send sorted by time in descending order appointments
            // to sortByDate method
            sortedByTimeAndDate = sortByDate(sortedByTime, in: "Descending Order")
            
        }
        
        // Return sorted appointments by both time and date array
        return sortedByTimeAndDate!
        
    }
    
    // MARK: - sortByDate
    /**
     SortByDate function sorts appointments array given as the
     parameter in order which is also given as a parameter and
     in its body it sorts the array by appointment's date value
     and sends it back to where it's called.
     
     -parameter sortedByTime: Appointments type array which is
     already sorted by their time values.
     -parameter order: Ascending or Descending Order in string.
     -returns: Sorted by time and date Appointment typed array
     in particular order.
     */
    private func sortByDate(_ sortedByTime: [Appointment],
                            in order: String) -> [Appointment] {
        
        var sortedByTimeAndDate: [Appointment]?
        
        // Sort appointments by date
        if order == "Ascending Order" {
            // In ascending order
            sortedByTimeAndDate = sortedByTime.sorted(by: {
                $0.date!.compare($1.date!) == .orderedAscending
            })
        } else if order == "Descending Order" {
            // In descending order
            sortedByTimeAndDate = sortedByTime.sorted(by: {
                $0.date!.compare($1.date!) == .orderedDescending
            })
        }
        
        // Return sorted appointments by both time and date array
        return sortedByTimeAndDate!
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
    
    func didPressProfileBarButton(_ homeView: HomeView) {
        homeRouter.navigateToProfilePage(homeView)
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
    
    func deleteAppointment(with appointmentID: Int) {
        homeInteractor.deleteAppointment(with: appointmentID)
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
    
    func didDeleteAppointment() {
        homeInteractor.fetchAppointmentsResponse()
    }
    
}
