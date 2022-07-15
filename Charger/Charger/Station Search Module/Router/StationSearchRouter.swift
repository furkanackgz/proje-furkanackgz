//
//  StationSearchRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 13.07.2022.
//

import UIKit

class StationSearchRouter: StationSearchContract.stationSearchRouter {
    
}

// Self related methods
extension StationSearchRouter {
    
    // MARK: - navigateToFilteringPage
    func navigateToFilteringPage(_ stationSearchView: StationSearchView,
                                 with filterChoices: [Filter]) {
        
        // Instantiate filtering module
        guard let filteringView = FilteringContract.instantiateFilteringModule(with: filterChoices) else { return }
        
        // Push filtering view onto station search view
        stationSearchView.navigationController?.pushViewController(filteringView,
                                                                   animated: true)
        
    }
    
    // MARK: - navigateToStationSocketsInfoPage
    func navigateToStationSocketsInfoPage(_ stationSearchView: StationSearchView,
                                          with stationID: Int, and date: String) {
        
    }
    
}
