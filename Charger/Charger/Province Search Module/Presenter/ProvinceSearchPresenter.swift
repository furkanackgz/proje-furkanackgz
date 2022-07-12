//
//  ProvinceSearchPresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 11.07.2022.
//

import Foundation

class ProvinceSearchPresenter: ProvinceSearchContract.provinceSearchPresenter {
    
    var provinceSearchView: ProvinceSearchContract.provinceSearchView!
    
    var provinceSearchInteractor: ProvinceSearchContract.provinceSearchInteractor!
    
    var provinceSearchRouter: ProvinceSearchContract.provinceSearchRouter!
    
}

// View related methods
extension ProvinceSearchPresenter {
    
    // MARK: - viewDidLoad
    func viewDidLoad() {
        provinceSearchInteractor.fetchProvinces()
    }
    
    // MARK: - didEditSearchText
    func didEditSearchText(_ searchText: String) {
        // Take provinces array from interactor layer
        guard let provinces = provinceSearchInteractor.provinces else { return }
        
        var filteredProvinces = [String]()
        
        // If user didn't enter any character to
        // the search text
        if searchText == "" {
            
            // Assign all provinces since there is no filtered
            // search text
            filteredProvinces = provinces
            
            // Call interactor to send filtered provinces for show them
            // in table view
            provinceSearchInteractor.updateFilteredProvinces(with: filteredProvinces, and: searchText)
            
        } else {
            
            // Assign provinces which contains search text in it
            // to the filtered provinces
            filteredProvinces = provinces.filter { $0.lowercased().contains(searchText.lowercased())
            }
            
            // Call interactor to send filtered provinces for show them
            // in table view
            provinceSearchInteractor.updateFilteredProvinces(with: filteredProvinces, and: searchText)
            
        }
        
    }
    
    // MARK: - didSelectProvince
    func didSelectProvince(_ provinceName: String,
                           _ provinceSearchView: ProvinceSearchView) {
        
        // Call router layer to navigate to station search page
        provinceSearchRouter.navigateToStationSearchPage(provinceName,
                                                         provinceSearchView)
    }
    
}

// Interactor related methods
extension ProvinceSearchPresenter {
    
    // MARK: - didFetchProvinces
    func didFetchProvinces() {
        // Fetch provinces from interactor layer
        guard let provinces = provinceSearchInteractor.provinces else { return }
        
        DispatchQueue.main.async { [weak self] in
            
            // Call update provinces table view in view layer
            self?.provinceSearchView.updateProvincesTableView(with: provinces, and: "")
            
            // Display table view
            self?.provinceSearchView.displayTableView("")
        }
    }
    
    // MARK: - didUpdateFilteredProvinces
    func didUpdateFilteredProvinces(with searchText: String) {
        // Fetch provinces from interactor layer
        guard let filteredProvinces = provinceSearchInteractor.filteredProvinces else { return }
        
        // If there is no provinces that are matched
        if filteredProvinces.count == 0 {
            
            // Display placeholder view
            provinceSearchView.displayPlaceholderView()
            
        } else {
            
            // Call update provinces table view method in
            // view layer with the filtered provinces and
            // search text that the user entered for filterning
            provinceSearchView.updateProvincesTableView(with: filteredProvinces, and: searchText)
            
            // Display table view
            provinceSearchView.displayTableView(searchText)
            
        }
        
    }
    
}
