//
//  AppointmentDetailsRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class AppointmentDetailsRouter: AppointmentDetailsContract.appointmentDetailsRouter {
    
    // MARK: - Properties
    var appointmentDetailsView: AppointmentDetailsView?
    
}

// Self related
extension AppointmentDetailsRouter {
    
    // MARK: - navigateBackToHomePage
    func navigateBackToHomePage() {
        
        // Unwrap appointment details view
        guard let appointmentDetailsView = appointmentDetailsView else { return }
        
        // Instantiate home view
        guard let homeView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeView else { return }
        
        // Navigate back to home page
        appointmentDetailsView.navigationController?.popToViewController(homeView, animated: true)
        
    }
    
}
