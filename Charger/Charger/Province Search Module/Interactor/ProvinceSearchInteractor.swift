//
//  ProvinceSearchInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 11.07.2022.
//

import Foundation

class ProvinceSearchInteractor: ProvinceSearchContract.provinceSearchInteractor {
    
    var provinces: [String]?
    
    var filteredProvinces: [String]?
    
    var provinceSearchPresenter: ProvinceSearchContract.provinceSearchPresenter?
    
}

// Presenter related methods
extension ProvinceSearchInteractor {
    
    // MARK: - fetchProvinces
    func fetchProvinces() {
        
        // Connect to web service and fetch provinces data
        ProvinceSearchService.run.sendProvincesRequest { [weak self] data in
            
            // If data received from server as a response
            if let data = data {
                
                // Decode data to string array
                do {
                    let provinces = try JSONDecoder().decode([String].self, from: data)
                    
                    // Assign it to the provinces array
                    self?.provinces = provinces
                    
                    // Call didFetchProvinces in presenter layer
                    self?.provinceSearchPresenter?.didFetchProvinces()
                    
                } catch let error {
                    print(error)
                }
                
            }
            
        }
        
    }
    
    // MARK: - updateFilteredProvinces
    func updateFilteredProvinces(with provinces: [String], and searchText: String) {
        
        // Assign filtered provinces the provinces which came
        // from presenter
        self.filteredProvinces = provinces
        
        // Call presenter to let it know filtered provinces is updated
        provinceSearchPresenter?.didUpdateFilteredProvinces(with: searchText)
    }
    
}
