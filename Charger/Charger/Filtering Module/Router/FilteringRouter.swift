//
//  FilteringRouter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 15.07.2022.
//

import UIKit

class FilteringRouter: FilteringContract.filteringRouter {

}

// Self related
extension FilteringRouter {
    
    // MARK: - navigateToStationSearchPage
    func navigateToStationSearchPage(_ filteringView: FilteringView) {
        
        // Pop filtering view out from stack view
        filteringView.navigationController?.popViewController(animated: true)
        
    }
    
}
