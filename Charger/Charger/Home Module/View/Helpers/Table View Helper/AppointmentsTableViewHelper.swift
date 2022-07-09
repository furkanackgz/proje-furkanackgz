//
//  AppointmentsTableViewHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 6.07.2022.
//

import UIKit

class AppointmentsTableViewHelper: NSObject {
    
    private var appointments = [AppointmentType]()
    
    private weak var appointmentsTableView: UITableView?
    
    var homePresenter: HomeContract.homePresenter!
    
    var homeView: HomeContract.homeView?
    
    // IsAppointmentsEmpty variable lets home view
    // know whether the appointments arrays empty in
    // each one of current and previous arrays, also
    // home view passes this info to presenter layer
    // for displaying either placeholder or table view.
    var isAppointmentsEmpty: Bool {
        get {
            // Check if current appointments are empty
            let isCurrentEmpty =
            appointments.first?.appointments.isEmpty
            
            // Check if previous appointments are empty
            let isPreviousEmpty =
            appointments.last?.appointments.isEmpty
            
            // If both of the arrays are empty return
            // true, otherwise return false
            return isCurrentEmpty! && isPreviousEmpty!
        }
    }
    
    init(_ appointmentsTableView: UITableView,
         _ homePresenter: HomeContract.homePresenter,
         _ homeView: HomeContract.homeView) {
        
        super.init()
        
        // Assign properties came from home view
        self.appointmentsTableView = appointmentsTableView
        self.homePresenter = homePresenter
        self.homeView = homeView
        
        // Assign self as delegate and data soruce of table view
        self.appointmentsTableView?.delegate = self
        self.appointmentsTableView?.dataSource = self
        
        // Register xib cell to the table view
        registerCells()
        
        // Register header view to the table view
        registerHeaderView()
    }
}

// Self related methods
extension AppointmentsTableViewHelper {
    
    // MARK: - registerCells
    private func registerCells() {
        
        /*
         Assign appointments table view helper to current
         appointment cell to handle pressing trash button.
        */
        assignSelfToCurrentAppointmentsCell()
        
        // Register current appointment cell to the table view
        appointmentsTableView?.register(.init(nibName: "CurrentAppointmentCell", bundle: nil), forCellReuseIdentifier: "CurrentAppointmentCell")
        
        // Register previous appointment cell to the table view
        appointmentsTableView?.register(.init(nibName: "PreviousAppointmentCell", bundle: nil), forCellReuseIdentifier: "PreviousAppointmentCell")
        
    }
    
    // MARK: - registerHeaderView
    private func registerHeaderView() {
        
        // Register appointments table view header to the table view
        appointmentsTableView?.register(AppointmentsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "AppointmentsTableViewHeader")
        
    }
    
    // MARK: - assignSelfToCurrentAppointmentsCell
    private func assignSelfToCurrentAppointmentsCell() {
        // Initialize current appointment cell
        if let currentAppointmentCell = UINib.init(nibName: "CurrentAppointmentCell", bundle: nil).instantiate(withOwner: nil).first as? CurrentAppointmentCell {
            // Assign self to current appointment cell
            currentAppointmentCell.helper = self
        }
    }
    
    /**
     This method is called by the current appointment
     table view cell, when the user press trash button
     inside the cell for deleting it.
     
     parameter appointmentID: This is required for
     identification of the spesific cell to be deleted.
     returns: None
     */
    // MARK: - didPressTrashButton
    func didPressTrashButton(_ appointmentID: Int) {
        homePresenter.deleteAppointment(with: appointmentID)
    }
    
    // MARK: - setAppointments
    func set(appointments: [AppointmentType]) {
        self.appointments = appointments
        
        // Animate reloding table view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.appointmentsTableView?.reloadData()
        }
        
    }
    
}

// MARK: TABLE VIEW DELEGATE
extension AppointmentsTableViewHelper: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Dequeue appointmens table header view
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AppointmentsTableViewHeader") as! AppointmentsTableViewHeader
        
        // Assign section name
        headerView.headerTitle.text = appointments[section].name
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK: TABLE VIEW DATA SOURCE
extension AppointmentsTableViewHelper: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments[section].appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Unwrap hasPassed variable
        if let hasPassed = appointments[indexPath.section].appointments[indexPath.row].hasPassed {
            
            /*
             Decide which type of table view cell will be initialized
             depending on cell's hasPassed value.
             */
            if !hasPassed {
                // Dequeue current appointment cell
                let currentAppointmentCell = dequeueCurrentAppointmentCell(tableView,
                                                                           indexPath)
                return currentAppointmentCell
            } else {
                // Dequeue previous appointment cell
                let previousAppointmentCell = dequeuePreviousAppointmentCell(tableView,
                                                                             indexPath)
                return previousAppointmentCell
            }
                
        }
        
        // To prevent application crashing add the default initializer
        return UITableViewCell()
    }
    
}

// MARK: - Dequeue Current Appointment Cell
extension AppointmentsTableViewHelper {
    
    private func dequeueCurrentAppointmentCell(_ tableView: UITableView,
                                               _ indexPath: IndexPath) -> CurrentAppointmentCell {
        
        var currentAppointmentCell: CurrentAppointmentCell?
        
        if let appointmentCell = tableView.dequeueReusableCell(withIdentifier: "CurrentAppointmentCell") as? CurrentAppointmentCell {
            
            // Set home view
            appointmentCell.homeView = homeView
            
            // Set table view helper
            appointmentCell.helper = self
            
            // Set appointment id
            appointmentCell.appointmentID = appointments[indexPath.section].appointments[indexPath.row].appointmentID
            
            // Initialize current appointment cell helper
            let currentAppointmentCellHelper = CurrentAppointmentCellHelper(appointments)
            
            // Set AC/DC image view
            currentAppointmentCellHelper.setACDCImageViewForCurrent(appointmentCell,
                                                                    indexPath)
            
            // Set station name label
            currentAppointmentCellHelper.setStationNameLabelForCurrent(appointmentCell,
                                                                       indexPath)
            
            // Set date and time label
            currentAppointmentCellHelper.setDateAndTimeLabelForCurrent(appointmentCell,
                                                                       indexPath)
            
            // Set kWh label
            currentAppointmentCellHelper.setKWhLabelForCurrent(appointmentCell,
                                                               indexPath)
            
            // Set socket number label
            currentAppointmentCellHelper.setSocketNumberLabelForCurrent(appointmentCell,
                                                                        indexPath)
            
            // Set socket type label
            currentAppointmentCellHelper.setSocketTypeLabelForCurrent(appointmentCell,
                                                                      indexPath)
            
            currentAppointmentCell = appointmentCell
        }
        
        // To prevent application crashing add the default initializer
        return currentAppointmentCell ?? CurrentAppointmentCell()
    }
    
}

// MARK: - Dequeue Previous Appointment Cell
extension AppointmentsTableViewHelper {
    
    private func dequeuePreviousAppointmentCell(_ tableView: UITableView,
                                                _ indexPath: IndexPath) -> PreviousAppointmentCell {
        
        var previousAppointmentCell: PreviousAppointmentCell?
        
        if let appointmentCell = tableView.dequeueReusableCell(withIdentifier: "PreviousAppointmentCell") as? PreviousAppointmentCell {
            
            // Initialize previous appointment cell helper
            let previousAppointmentCellHelper = PreviousAppointmentCellHelper(appointments)
            
            
            // Set AC/DC image view
            previousAppointmentCellHelper.setACDCImageViewForPrevious(appointmentCell,
                                                                      indexPath)
            
            // Set station name label
            previousAppointmentCellHelper.setStationNameLabelForPrevious(appointmentCell,
                                                                         indexPath)
            
            // Set date and time label
            previousAppointmentCellHelper.setDateAndTimeLabelForPrevious(appointmentCell,
                                                                         indexPath)
            
            // Set kWh label
            previousAppointmentCellHelper.setKWhLabelForPrevious(appointmentCell,
                                                                 indexPath)
            
            // Set socket number label
            previousAppointmentCellHelper.setSocketNumberLabelForPrevious(appointmentCell,
                                                                          indexPath)
            
            // Set socket type label
            previousAppointmentCellHelper.setSocketTypeLabelForPrevious(appointmentCell,
                                                                        indexPath)
            
            previousAppointmentCell = appointmentCell
        }
        
        // To prevent application crashing add the default initializer
        return previousAppointmentCell ?? PreviousAppointmentCell()
    }
    
}
