//
//  ProfileInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import Foundation

class ProfileInteractor: ProfileContract.profileInteractor {
    
    var profilePresenter: ProfileContract.profilePresenter?
    
}

// Self related methods
extension ProfileInteractor {

    func sendLogoutRequest(_ profileView: ProfileView) {
        
        // Send logout request to the server
        ProfileService.run.sendLogoutRequest { [weak self] succeed in
            
            // Send logout response of succeed to presenter
            self?.profilePresenter?.didReceiveLogoutResponse(succeed,
                                                             profileView)
            
        }
        
    }
    
}

