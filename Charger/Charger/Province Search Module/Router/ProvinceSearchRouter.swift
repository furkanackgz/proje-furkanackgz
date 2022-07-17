//
//  ProvinceSearchRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 11.07.2022.
//

import UIKit

class ProvinceSearchRouter: ProvinceSearchContract.provinceSearchRouter {
    
    // MARK: Properties
    var homeView: HomeView?

}

// Self related methods
extension ProvinceSearchRouter {
    
    // MARK: - navigateToStationSearchPage
    func navigateToStationSearchPage(_ provinceName: String, _ provinceSearchView: ProvinceSearchView) {
        
        // Instantiate station search module
        guard let stationSearchView = StationSearchContract.instantiateStationSearchModule(with: provinceName, and: homeView!) else { return }
        
        // Push station search view onto province search view
        provinceSearchView.navigationController?.pushViewController(stationSearchView, animated: true)
        
    }
    
}
