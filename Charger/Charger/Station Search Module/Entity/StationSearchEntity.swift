//
//  StationSearchEntity.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 13.07.2022.
//

import Foundation

class StationSearchEntity: StationSearchContract.stationSearchEntity {
    
    var decodedAllStationsResponse = [Station]()
    
    var stationSearchInteractor: StationSearchContract.stationSearchInteractor?
    
}

// Self related methods
extension StationSearchEntity {
    
    func decodeAllStationsResponse(_ data: Data) {
        
        // Decode response data to all stations
        do {
            decodedAllStationsResponse = try JSONDecoder().decode([Station].self,
                                                                  from: data)
            // If there is no error occured while decoding, call interactor
            stationSearchInteractor?.didDecodeAllStationsResponse()
        } catch let error {
            print(error)
        }
        
    }
    
}
