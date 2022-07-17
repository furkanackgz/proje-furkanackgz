//
//  AppointmentDetailsTableViewHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class AppointmentDetailsTableViewHelper: NSObject {
    
    // MARK: - Properties
    private var appointmentDetails = [AppointmentDetail]()
    
    private weak var appointmentDetailsTableView: UITableView!
    
    private var appointmentDetailsPresenter: AppointmentDetailsContract.appointmentDetailsPresenter!
    
    // MARK: - init
    init(_ appointmentDetailsTableView: UITableView,
         _ appointmentDetailsPresenter: AppointmentDetailsContract.appointmentDetailsPresenter) {
        
        super.init()
        
        // Assign properties came from view layer
        self.appointmentDetailsTableView = appointmentDetailsTableView
        self.appointmentDetailsPresenter = appointmentDetailsPresenter
        
        // Assign self as delegate and data source of the table view
        self.appointmentDetailsTableView.delegate = self
        self.appointmentDetailsTableView.dataSource = self
        
        // Register header
        registerHeaderView()
        
        // Register cells
        registerCells()
        
    }
    
}

// Self related methods
extension AppointmentDetailsTableViewHelper {
    
    // MARK: - registerHeaderView
    private func registerHeaderView() {
        
        // Register appointment details table view header to the table view
        appointmentDetailsTableView?.register(AppointmentDetailsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "AppointmentDetailsTableViewHeader")
        
    }
    
    // MARK: - registerCells
    private func registerCells() {
        
        // Register station informations cell to the table view
        appointmentDetailsTableView.register(.init(nibName: "StationInformationsCell", bundle: nil), forCellReuseIdentifier: "StationInformationsCell")
        
        // Register socket informations cell to the table view
        appointmentDetailsTableView.register(.init(nibName: "SocketInformationsCell", bundle: nil), forCellReuseIdentifier: "SocketInformationsCell")
        
        // Register appointment informations cell to the table view
        appointmentDetailsTableView.register(.init(nibName: "AppointmentInformationsCell", bundle: nil), forCellReuseIdentifier: "AppointmentInformationsCell")
        
    }
    
    // MARK: - setAppointmentDetails
    func set(appointmentDetails: [AppointmentDetail]) {
        self.appointmentDetails = appointmentDetails
        
        // Animate reloding table view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.appointmentDetailsTableView?.reloadData()
        }
    }
    
}

// MARK: Table View Delegate
extension AppointmentDetailsTableViewHelper: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Dequeue appointment details table header view
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AppointmentDetailsTableViewHeader") as! AppointmentDetailsTableViewHeader
        
        // Assign section name
        headerView.headerTitle.text = appointmentDetails[section].sectionName
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK: Table View Data Source
extension AppointmentDetailsTableViewHelper: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appointmentDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentDetails[section].sectionDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appointmentDetail = appointmentDetails[indexPath.section]
        
        switch appointmentDetail.sectionName {
        case "İSTASYON BİLGİLERİ":
            
            // Dequeue station informations cell
            let stationInformationsCell = dequeueStationInformationsCell(tableView,
                                               indexPath, appointmentDetail)
            
            // Return station informations cell
            return stationInformationsCell
            
        case "SOKET BİLGİLERİ":
            
            // Dequeue socket informations cell
            let socketInformationsCell = dequeueSocketInformationsCell(tableView, indexPath, appointmentDetail)
            
            // Return socket informations cell
            return socketInformationsCell
            
        case "RANDEVU BİLGİLERİ":
            
            // Dequeue appointment informations cell
            let appointmentInformationsCell = dequeueAppointmentInformationsCell(tableView, indexPath, appointmentDetail)
            
            // Return appointment informations cell
            return appointmentInformationsCell
            
        default:
            
            // If the section name is not found for some reason,
            // return default ui table view cell for preventing
            // crash
           return UITableViewCell()
            
        }
        
    }
    
}

// MARK: - dequeueStationInformationsCell
extension AppointmentDetailsTableViewHelper {
    
    private func dequeueStationInformationsCell(_ tableView: UITableView,
                                                _ indexPath: IndexPath,
                                                _ appointmentDetail: AppointmentDetail) -> StationInformationsCell {
        
        let sectionDetail = appointmentDetail.sectionDetail
        
        var stationInformationsCellResult: StationInformationsCell?
        
        if let stationInformationsCell = tableView.dequeueReusableCell(withIdentifier: "StationInformationsCell") as? StationInformationsCell {
            
            // Initialize station informations cell helper
            let stationInformationsCellHelper = StationInformationsCellHelper(sectionDetail, stationInformationsCell, indexPath)
            
            // Set address stack
            stationInformationsCellHelper.setAddressStack()
            
            // Set service hours stack
            stationInformationsCellHelper.setServiceHoursStack()
            
            // Set distance stack
            stationInformationsCellHelper.setDistanceStack()
            
            // Set station code stack
            stationInformationsCellHelper.setStationCodeStack()
            
            // Set services stack
            stationInformationsCellHelper.setServicesStack()
            
            // Assign initialized and set station cell
            stationInformationsCellResult = stationInformationsCell
        }
        
        // To prevent application crashing add the default initializer
        return stationInformationsCellResult ?? StationInformationsCell()
        
    }
    
}

// MARK: - dequeueSocketInformationsCell
extension AppointmentDetailsTableViewHelper {
    
    private func dequeueSocketInformationsCell(_ tableView: UITableView,
                                               _ indexPath: IndexPath,
                                               _ appointmentDetail: AppointmentDetail) -> SocketInformationsCell {
        
        let sectionDetail = appointmentDetail.sectionDetail
        
        var socketInformationsCellResult: SocketInformationsCell?
        
        if let socketInformationsCell = tableView.dequeueReusableCell(withIdentifier: "SocketInformationsCell") as? SocketInformationsCell {
            
            // Initialize socket informations cell helper
            let socketInformationsCellHelper = SocketInformationsCellHelper(sectionDetail, socketInformationsCell, indexPath)
            
            // Set socket number stack
            socketInformationsCellHelper.setSocketNumberStack()
            
            // Set charge type stack
            socketInformationsCellHelper.setChargeTypeStack()
            
            // Set socket type stack
            socketInformationsCellHelper.setSocketTypeStack()
            
            // Set power and power unit stack
            socketInformationsCellHelper.setPowerAndPowerUnitStack()
            
            // Assign initialized and set socket informations cell
            socketInformationsCellResult = socketInformationsCell
        }
        
        // To prevent application crashing add the default initializer
        return socketInformationsCellResult ?? SocketInformationsCell()
        
    }
    
}

// MARK: - dequeueAppointmentInformationsCell
extension AppointmentDetailsTableViewHelper {
    
    private func dequeueAppointmentInformationsCell(_ tableView: UITableView,
                                                    _ indexPath: IndexPath,
                                                    _ appointmentDetail: AppointmentDetail) -> AppointmentInformationsCell {
        
        let sectionDetail = appointmentDetail.sectionDetail
        
        var appointmentInformationsCellResult: AppointmentInformationsCell?
        
        if let appointmentInformationsCell = tableView.dequeueReusableCell(withIdentifier: "AppointmentInformationsCell") as? AppointmentInformationsCell {
            
            // Set presenter to appointment informations cell
            appointmentInformationsCell.appointmentDetailsPresenter = appointmentDetailsPresenter
            
            // Initialize appointment informations cell helper
            let appointmentInformationsCellHelper = AppointmentInformationsCellHelper(sectionDetail, appointmentInformationsCell, indexPath)
            
            // Set date stack
            appointmentInformationsCellHelper.setDateStack()
            
            // Set hour stack
            appointmentInformationsCellHelper.setHourStack()
            
            // Set appointment duration stack
            appointmentInformationsCellHelper.setAppointmentDurationStack()
            
            // Set get notification title label
            appointmentInformationsCellHelper.setGetNotificationTitleLabel()
            
            // Get the switch state
            let isSwitchOn = appointmentInformationsCell.notificationSwitch.isOn
            
            // If switch is set to on
            if  isSwitchOn {
                
                appointmentInformationsCellHelper.setSwitchOn()
                appointmentInformationsCellHelper.displayDropDownStack()
                appointmentInformationsCellHelper.setDropDownStack()
                
            } else {
                
                appointmentInformationsCellHelper.setSwitchOff()
                appointmentInformationsCellHelper.hideDropDownStack()
                
            }
            
            // Assign initialized and set appointment informations cell
            appointmentInformationsCellResult = appointmentInformationsCell
        }
        
        // To prevent application crashing add the default initializer
        return appointmentInformationsCellResult ?? AppointmentInformationsCell()
        
    }
    
}
