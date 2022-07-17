//
//  ProfilePresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import Foundation

class ProfilePresenter: ProfileContract.profilePresenter {
    
    // MARK: - Properties
    var profileView: ProfileContract.profileView!
    
    var profileInteractor: ProfileContract.profileInteractor!
    
    var profileRouter: ProfileContract.profileRouter!
    
}

// Self related methods
extension ProfilePresenter {
    
    // MARK: - fetchProfileViewData
    private func fetchProfileViewData() {
        
        // Fetch email from user defaults
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }

        // Fetch deviceID
        guard let deviceID = UserDefaults.standard.string(forKey: "deviceID") else { return }
        
        // Set email and deviceID to their value labels in profile view
        profileView.setProfileViewData(with: email, and: deviceID)
        
    }
    
}

// View related methods
extension ProfilePresenter {
    
    // MARK: - viewDidLoad
    func viewDidLoad() {
        
        // Fetch profile view data
        fetchProfileViewData()
        
    }
    
    // MARK: - didPressCikisYapButton
    func didPressCikisYapButton(_ profileView: ProfileView) {
        
        // Call sendLogoutRequest in interactor layer
        profileInteractor.sendLogoutRequest(profileView)
        
    }
    
}

// Interactor related methods
extension ProfilePresenter {
    
    // MARK: - didReceiveLogoutResponse
    func didReceiveLogoutResponse(_ succeed: Bool,
                                  _ profileView: ProfileView) {
        
        DispatchQueue.main.async { [weak self] in
            
            if succeed {
                
                // Call router layer for navigating to login page
                self?.profileRouter.navigateToLoginPage(profileView)
                
            } else {
                
                // Show an alert to notify the user about not
                // being able to logout safely
                self?.profileView.showAlert(with: "Hata",
                                            and: "Çıkış yapılamadı!")
                
            }
            
        }
        
    }
    
}

