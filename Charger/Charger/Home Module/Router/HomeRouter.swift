//
//  HomeRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import UIKit

class HomeRouter: HomeContract.homeRouter {
    
}

// MARK: - SELF RELATED METHODS
extension HomeRouter {
    
    func navigateToProfilePage(_ homeView: HomeView) {
        
        // Instantiate profile module
        guard let profileView = ProfileContract.instantiateProfileModule() else { return }
        
        // Push profile view onto home view
        homeView.navigationController?.pushViewController(profileView, animated: true)
        
    }
    
    func navigateToProvinceSearchPage(_ homeView: HomeView) {
        
        // Instantiate province search module
        guard let provinceSearchView = ProvinceSearchContract.instantiateProvinceSearchModule() else { return }
        
        // Push province search view onto home view
        homeView.navigationController?.pushViewController(provinceSearchView, animated: true)
        
    }
    
}
