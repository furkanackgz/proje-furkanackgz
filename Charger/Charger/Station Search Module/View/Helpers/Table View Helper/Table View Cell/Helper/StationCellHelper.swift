//
//  StationCellHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 12.07.2022.
//

import UIKit

class StationCellHelper: NSObject {
    
    // MARK: - Properties
    private var stationsInProvince = [Station]()
    
    private var stationCell: StationCell!
    
    private var indexPath: IndexPath!
    
    // MARK: - init
    init(_ stationsInProvince: [Station],
         _ stationCell: StationCell,
         _ indexPath: IndexPath) {
        
        // Assign properties came from table view helper
        self.stationsInProvince = stationsInProvince
        self.stationCell = stationCell
        self.indexPath = indexPath
        
    }
    
}

// Station cell helper methods
extension StationCellHelper {
    
    // MARK: - setACDCImageView
    func setACDCImageView() {
        
        var AC: Bool?
        var DC: Bool?
        
        // Get the sockets of the station
        guard let sockets = stationsInProvince[indexPath.row].sockets else { return }
        
        // Check whether station provides which type of charges
        sockets.forEach { socket in
            
            switch socket.chargeType {
            case "AC":
                AC = true
            case "DC":
                DC = true
            default:
                break
            }
            
        }
        
        // Station supports both type of charges
        if let _ = AC, let _ = DC{
            stationCell.ACDCImageView.image = ThemeManager.image.logoAcDc
        }
        // Station supports only AC type of charge
        else if let _ = AC {
            stationCell.ACDCImageView.image = ThemeManager.image.logoAc
        }
        // Station supports only DC type of charge
        else if let _ = DC {
            stationCell.ACDCImageView.image = ThemeManager.image.logoDC
        }
        
    }
    
    // MARK: - setStationNameLabel
    func setStationNameLabel() {
        
        // Unwrap station name variable
        guard let stationName = stationsInProvince[indexPath.row].stationName else { return }
        
        stationCell.stationNameLabel.font = UIFont.systemFont(ofSize: 20,
                                                                         weight: .bold)
        stationCell.stationNameLabel.textColor = ThemeManager.color.title
        stationCell.stationNameLabel.text = stationName
        
    }
    
    // MARK: - setServiceHoursLabel
    func setServiceHoursLabel() {
        
        // Create first part attributes
        let firstPartAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: ThemeManager.color.subtitle!
        ]
        
        // Create first part of attributed string
        let firstPart = NSMutableAttributedString(string: "Hizmet saatleri: ",
                                                  attributes: firstPartAttributes)
        
        // Create second part attributes
        let secondPartAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: ThemeManager.color.title!
        ]
        
        // Create second part of attributed string
        let secondPart = NSAttributedString(string: "24 Saat",
                                            attributes: secondPartAttributes)
        
        // Concatenate first and second part
        firstPart.append(secondPart)
        
        // Assign concatenated string to service hours label
        stationCell.serviceHoursLabel.attributedText = firstPart
        
    }
    
    // MARK: - setDistanceLabel
    func setDistanceLabel() {
        
        // Unwrap distance in km label of station
        if let distanceInKM = stationsInProvince[indexPath.row].distanceInKM {
            
            // If distance info came from server
            stationCell.distanceLabel.font = .systemFont(ofSize: 16, weight: .regular)
            stationCell.distanceLabel.textColor = ThemeManager.color.title
            stationCell.distanceLabel.text = String(format: "%.1f km", distanceInKM)
            
        } else {
            
            // If distance info did not come from server
            stationCell.distanceLabel.text = ""
            
        }
        
    }
    
    // MARK: - setAvaliableSocketNumberLabel
    func setAvaliableSocketNumberLabel() {
        
        // Create first part attributes
        let firstPartAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: ThemeManager.color.subtitle!
        ]
        
        // Create first part of attributed string
        let firstPart = NSMutableAttributedString(string: "Uygun soket sayısı: ",
                                                  attributes: firstPartAttributes)
        
        // Create second part attributes
        let secondPartAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: ThemeManager.color.title!
        ]
        
        // Fetch occupied socket count
        guard let occupiedSocketCount = stationsInProvince[indexPath.row].occupiedSocketCount else { return }
        
        // Fetch socket count
        guard let socketCount = stationsInProvince[indexPath.row].socketCount else { return }
        
        let secondPartString = "\(occupiedSocketCount) / \(socketCount)"
        
        // Create second part of attributed string
        let secondPart = NSAttributedString(string: secondPartString,
                                            attributes: secondPartAttributes)
        
        // Concatenate first and second part
        firstPart.append(secondPart)
        
        // Assign concatenated string to avaliable socket number label
        stationCell.avaliableSocketNumberLabel.attributedText = firstPart
        
    }
    
}

