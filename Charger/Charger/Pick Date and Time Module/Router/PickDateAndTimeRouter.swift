//
//  PickDateAndTimeRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import UIKit

class PickDateAndTimeRouter: PickDateAndTimeContract.pickDateAndTimeRouter {
    
    // MARK: - Properties
    var homeView: HomeView?
    
}

// Self related
extension PickDateAndTimeRouter {
    
    // MARK: - navigateToAppointmentDetailsPage
    func navigateToAppointmentDetailsPage(_ pickDateAndTimeView: PickDateAndTimeView,
                                          _ stationInfo: StationInfo,
                                          _ appointmentRequest: AppointmentRequest) {
        
        // Instantiate appointment details page
        guard let appointmentDetailsView = AppointmentDetailsContract.instantiateAppointmentDetailsModule(stationInfo, appointmentRequest, homeView!) else { return }
        
        // Push appointment details view onto pick date and time view
        pickDateAndTimeView.navigationController?.pushViewController(appointmentDetailsView, animated: true)
        
    }
    
}
