//
//  AppointmentDetailsRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class AppointmentDetailsRouter: AppointmentDetailsContract.appointmentDetailsRouter {
    
    // MARK: - Properties
    var homeView: HomeView?
    
    var appointmentDetailsView: AppointmentDetailsView?
    
}

// Self related
extension AppointmentDetailsRouter {
    
    // MARK: - navigateBackToHomePage
    func navigateBackToHomePage() {
        
        // Unwrap appointment details view
        guard let appointmentDetailsView = appointmentDetailsView else { return }
        
        // Call it in main queue since it is called from background thread
        DispatchQueue.main.async { [weak self] in
            
            // Navigate back to home page
            appointmentDetailsView.navigationController?.popToViewController((self?.homeView)!,
                                                                             animated: true)
            
        }
        
    }
    
}
