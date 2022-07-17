//
//  StationInformationsCellHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class StationInformationsCellHelper: NSObject {
    
    // MARK: - Properties
    private var sectionDetail = [RowDetail]()
    
    private var stationInformationsCell: StationInformationsCell!
    
    private var indexPath: IndexPath!
    
    // MARK: - init
    init(_ sectionDetail: [RowDetail],
         _ stationInformationsCell: StationInformationsCell,
         _ indexPath: IndexPath) {
        
        super.init()
        
        // Assign properties came from table view helper
        self.sectionDetail = sectionDetail
        self.stationInformationsCell = stationInformationsCell
        self.indexPath = indexPath
        
    }
    
}

// Self related methods
extension StationInformationsCellHelper {
    
    // MARK: - setAddressStack
    func setAddressStack() {
        
        guard let cell = stationInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set address title label
        cell.addressTitleLabel.text = sectionDetail.rowTitle
        cell.addressTitleLabel.textColor = ThemeManager.color.title
        cell.addressTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                        weight: .bold)
        
        // Set address value label
        cell.addressValueLabel.text = sectionDetail.rowValue
        cell.addressValueLabel.textColor = ThemeManager.color.subtitle
        cell.addressValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                        weight: .regular)
        
    }
    
    // MARK: - setServiceHoursStack
    func setServiceHoursStack() {
        
        guard let cell = stationInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set service hours title label
        cell.serviceHoursTitleLabel.text = sectionDetail.rowTitle
        cell.serviceHoursTitleLabel.textColor = ThemeManager.color.title
        cell.serviceHoursTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                             weight: .bold)
        
        // Set service hours value label
        cell.serviceHoursValueLabel.text = "24 Saat"
        cell.serviceHoursValueLabel.textColor = ThemeManager.color.subtitle
        cell.serviceHoursValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                             weight: .regular)
        
    }
    
    // MARK: - setDistanceStack
    func setDistanceStack() {
        
        guard let cell = stationInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set distance title label
        cell.distanceTitleLabel.text = sectionDetail.rowTitle
        cell.distanceTitleLabel.textColor = ThemeManager.color.title
        cell.distanceTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                         weight: .bold)
        
        // Set distance value label
        cell.distanceValueLabel.text = sectionDetail.rowValue
        cell.distanceValueLabel.textColor = ThemeManager.color.subtitle
        cell.distanceValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                         weight: .regular)
        
    }
    
    // MARK: - setStationCodeStack
    func setStationCodeStack() {
        
        guard let cell = stationInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set station code title label
        cell.stationCodeTitleLabel.text = sectionDetail.rowTitle
        cell.stationCodeTitleLabel.textColor = ThemeManager.color.title
        cell.stationCodeTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                            weight: .bold)
        
        // Set station code value label
        cell.stationCodeValueLabel.text = sectionDetail.rowValue
        cell.stationCodeValueLabel.textColor = ThemeManager.color.subtitle
        cell.stationCodeValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                            weight: .regular)
        
    }
    
    // MARK: - setServicesStack
    func setServicesStack() {
        
        guard let cell = stationInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set services title label
        cell.servicesTitleLabel.text = sectionDetail.rowTitle
        cell.servicesTitleLabel.textColor = ThemeManager.color.title
        cell.servicesTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                         weight: .bold)
        
        // Set services value label
        cell.servicesValueLabel.text = sectionDetail.rowValue
        cell.servicesValueLabel.textColor = ThemeManager.color.subtitle
        cell.servicesValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                         weight: .regular)
        
    }
    
}
