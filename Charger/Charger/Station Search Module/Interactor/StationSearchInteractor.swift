//
//  StationSearchInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 13.07.2022.
//

import Foundation

class StationSearchInteractor: StationSearchContract.stationSearchInteractor {
    
    // MARK: - Properties
    var allStations = [Station]()
    
    var stationsInProvince = [Station]()
    
    var filteredStationsInProvince = [Station]()
    
    var filterChoices = [Filter]()
    
    var stationSearchPresenter: StationSearchContract.stationSearchPresenter?
    
    var stationsSearchEntity: StationSearchContract.stationSearchEntity!
    
}

// Self related methods
extension StationSearchInteractor {
    
    // MARK: - fetchAllStations
    func fetchAllStations() {
        
        StationSearchService.run.sendAllStationsRequest { [weak self] data in
            
            // Unwrap data
            guard let data = data else { return }
            
            // Send data to entity layer for decoding
            self?.stationsSearchEntity.decodeAllStationsResponse(data)
            
        }
        
    }
    
}

// Presenter related methods
extension StationSearchInteractor {
    
    // MARK: - setStationsInProvince
    func setStationsInProvince(with stationsInProvince: [Station]) {
        
        // Set stations in province
        self.stationsInProvince = stationsInProvince
        
        // Let presenter know that stationsInProvince is set
        stationSearchPresenter?.didSetStationsInProvince()
        
    }
    
    // MARK: - setFilteredStationsInProvince
    func setFilteredStationsInProvince(with filteredStationsInProvince: [Station]) {
        
        // Set filtered stations in province
        self.filteredStationsInProvince = filteredStationsInProvince
        
        // Let presenter know that filteredStationsInProvince is set
        self.stationSearchPresenter?.didSetFilteredStationsInProvince()
        
    }
    
    // MARK: - setFilterChoices
    func setFilterChoices(with filterChoices: [Filter]) {
        
        // Set filter choices to
        self.filterChoices = filterChoices
        
        // Let presenter know that filter choices are set
        stationSearchPresenter?.didSetFilterChoices()
        
    }
    
}

// Entity related methods
extension StationSearchInteractor {
    
    // MARK: - didDecodeAllStationsResponse
    func didDecodeAllStationsResponse() {
        
        // Take decoded all stations response from entity layer
        let allStations = stationsSearchEntity.decodedAllStationsResponse
        
        // Assign it to allStations array of self
        self.allStations = allStations
        
        // Let presenter know that all stations are fetched
        stationSearchPresenter?.didFetchAllStations()
        
    }
    
}
