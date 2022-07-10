//
//  ProfileRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import UIKit

class ProfileRouter {

}

// Self related methods
extension ProfileRouter: ProfileContract.profileRouter  {
    
    // Navigate to login page
    func navigateToLoginPage(_ profileView: ProfileView) {
        
        // Animate navigation for better user experience
        UIView.animate(withDuration: 1, delay: 1) {
            
            // Pop to root view controller which is login view
            profileView.navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
    
}
