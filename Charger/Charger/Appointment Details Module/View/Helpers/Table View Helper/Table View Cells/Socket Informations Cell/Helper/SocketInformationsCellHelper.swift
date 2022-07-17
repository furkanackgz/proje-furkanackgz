//
//  SocketInformationsCellHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class SocketInformationsCellHelper: NSObject {
    
    // MARK: - Properties
    private var sectionDetail = [RowDetail]()
    
    private var socketInformationsCell: SocketInformationsCell!
    
    private var indexPath: IndexPath!
    
    // MARK: - init
    init(_ sectionDetail: [RowDetail],
         _ socketInformationsCell: SocketInformationsCell,
         _ indexPath: IndexPath) {
        
        super.init()
        
        // Assign properties came from view layer
        self.sectionDetail = sectionDetail
        self.socketInformationsCell = socketInformationsCell
        self.indexPath = indexPath
        
    }
    
}

// Self related methods
extension SocketInformationsCellHelper {
    
    // MARK: - setSocketNumberStack
    func setSocketNumberStack() {
        
        guard let cell = socketInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set socket number title label
        cell.socketNumberTitleLabel.text = sectionDetail.rowTitle
        cell.socketNumberTitleLabel.textColor = ThemeManager.color.title
        cell.socketNumberTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                             weight: .bold)
        
        // Set socket number value label
        cell.socketNumberValueLabel.text = sectionDetail.rowValue
        cell.socketNumberValueLabel.textColor = ThemeManager.color.subtitle
        cell.socketNumberValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                             weight: .regular)
        
    }
    
    // MARK: - setChargeTypeStack
    func setChargeTypeStack() {
        
        guard let cell = socketInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set charge type title label
        cell.chargeTypeTitleLabel.text = sectionDetail.rowTitle
        cell.chargeTypeTitleLabel.textColor = ThemeManager.color.title
        cell.chargeTypeTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                           weight: .bold)
        
        // Set charge type value label
        cell.chargeTypeValueLabel.text = sectionDetail.rowValue
        cell.chargeTypeValueLabel.textColor = ThemeManager.color.subtitle
        cell.chargeTypeValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                           weight: .regular)
        
    }
    
    // MARK: - setSocketTypeStack
    func setSocketTypeStack() {
        
        guard let cell = socketInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set socket type title label
        cell.socketTypeTitleLabel.text = sectionDetail.rowTitle
        cell.socketTypeTitleLabel.textColor = ThemeManager.color.title
        cell.socketTypeTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                           weight: .bold)
        
        // Set socket type value label
        cell.socketTypeValueLabel.text = sectionDetail.rowValue
        cell.socketTypeValueLabel.textColor = ThemeManager.color.subtitle
        cell.socketTypeValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                           weight: .regular)
        
    }
    
    // MARK: - setPowerAndPowerUnitStack
    func setPowerAndPowerUnitStack() {
        
        guard let cell = socketInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set power and power unit title label
        cell.powerAndPowerUnitTitleLabel.text = sectionDetail.rowTitle
        cell.powerAndPowerUnitTitleLabel.textColor = ThemeManager.color.title
        cell.powerAndPowerUnitTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                                  weight: .bold)
        
        // Set power and power unit value label
        cell.powerAndPowerUnitValueLabel.text = sectionDetail.rowValue
        cell.powerAndPowerUnitValueLabel.textColor = ThemeManager.color.subtitle
        cell.powerAndPowerUnitValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                                  weight: .regular)
        
    }
    
}
