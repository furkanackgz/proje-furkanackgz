//
//  PickDateAndTimeEntity.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import Foundation

class PickDateAndTimeEntity: PickDateAndTimeContract.pickDateAndTimeEntity {
    
    // MARK: - Properties
    var decodedStationInfo: StationInfo?
    
    var pickDateAndTimeInteractor: PickDateAndTimeContract.pickDateAndTimeInteractor?
    
}

// Self related
extension PickDateAndTimeEntity {
    
    // MARK: - decodeStationInfoResponse
    func decodeStationInfoResponse(_ data: Data) {
        
        do {
            
            decodedStationInfo = try JSONDecoder().decode(StationInfo.self, from: data)
            
            // If there is no error with decoding process, call interactor
            pickDateAndTimeInteractor?.didDecodeStationInfo()
            
        } catch let error {
            print(error)
        }
        
    }
    
}
