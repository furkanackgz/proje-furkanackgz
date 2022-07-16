//
//  SocketTableViewHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import UIKit

class SocketTableViewHelper: NSObject {
    
    private var timeSlots = [TimeSlotInfo]()
    
    private var socketInfo: SocketInfo?
    
    private weak var socketTableView: UITableView?
    
    private var pickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter!
    
    private var selectedCellIndexPath: IndexPath?
    
    init(_ socketInfo: SocketInfo,
         _ socketTableView: UITableView,
         _ pickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter) {
        
        super.init()
        
        // Assign properties came from view layer
        self.socketInfo = socketInfo
        self.socketTableView = socketTableView
        self.pickDateAndTimePresenter = pickDateAndTimePresenter
        
        // Assign self as delegate and data source of table view
        self.socketTableView?.delegate = self
        self.socketTableView?.dataSource = self
        
        // Register cell
        registerCell()
        
    }
    
}

// Self related
extension SocketTableViewHelper {
    
    // MARK: - setSocketInfo
    func set(_ timeSlots: [TimeSlotInfo]) {
        self.timeSlots = timeSlots
        
        // Animate reloding table view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.socketTableView?.reloadData()
        }
    }
    
    // MARK: - registerCell
    private func registerCell() {
        
        // Register time slot cell to socket table view
        socketTableView?.register(.init(nibName: "TimeSlotCell", bundle: nil), forCellReuseIdentifier: "TimeSlotCell")
        
    }
    
}

// MARK: - Table View Delegate
extension SocketTableViewHelper: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Take the indexPath of selected time slot cell
        selectedCellIndexPath = tableView.indexPathForSelectedRow
        
        // Reload the table view for the selected cells
        tableView.reloadRows(at: [selectedCellIndexPath!], with: .none)
        
        // Create user info
        let socketID = socketInfo?.socketID
        let slot = timeSlots[indexPath.row].slot

        let userInfo = [
            "socketID": socketID as Any,
            "slot": slot as Any
        ]
        
        // Post a notification to let other cells know that it's selected
        // with userInfo parameter
        NotificationCenter.default.post(name: .timeSlotSelected,
                                        object: nil,
                                        userInfo: userInfo)
        
        // Get appointment date
        let appointmentDate = socketInfo?.day?.date
        
        // Call did select time slot method
        pickDateAndTimePresenter.didSelectTimeSlot(socketID!, slot!, appointmentDate!)
        
        
    }
    
}

// MARK: - Table View Data Source
extension SocketTableViewHelper: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timeSlotCell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotCell") as! TimeSlotCell
        
        // Set cell properties
        timeSlotCell.socketID = socketInfo?.socketID
        timeSlotCell.slot = timeSlots[indexPath.row].slot
        timeSlotCell.timeSlotLabel.text = timeSlots[indexPath.row].slot
        
        // If cell is already occupied
        if timeSlots[indexPath.row].isOccupied! {
            
            // Set cell as disabled and label color as subtitle color
            timeSlotCell.isUserInteractionEnabled = false
            timeSlotCell.timeSlotLabel.textColor = .gray
            
        } else {
            
            // If not, set cell as enabled and label color as title color
            timeSlotCell.isUserInteractionEnabled = true
            timeSlotCell.timeSlotLabel.textColor = ThemeManager.color.title
            
        }
        
        // If cell is selected, change it's background and border color
        if indexPath.row == selectedCellIndexPath?.row {
            
            // Set container view's background as selected
            timeSlotCell.containerView.backgroundColor = ThemeManager.color.chosenCellBackground
            
            // Set container view's border color as selected
            timeSlotCell.containerView.layer.borderColor = ThemeManager.color.chosenCellBorder?.cgColor
            
        } else {
            
            // Set container view's background as default
            timeSlotCell.containerView.backgroundColor = ThemeManager.color.accent
            
            // Set container view's border color as default
            timeSlotCell.containerView.layer.borderColor = ThemeManager.color.accent?.cgColor
        }
        
        return timeSlotCell
    }
    
}
