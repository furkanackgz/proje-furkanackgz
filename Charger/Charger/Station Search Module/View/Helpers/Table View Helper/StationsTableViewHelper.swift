//
//  StationTableViewHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 12.07.2022.
//

import UIKit

class StationsTableViewHelper: NSObject {
    
    // MARK: - Property
    private var stationsInProvince = [Station]()
    
    private weak var stationsTableView: UITableView?
    
    private var stationSearchPresenter: StationSearchContract.stationSearchPresenter!
    
    private var stationSearchView: StationSearchView?
    
    // MARK: - init
    init(_ stationsTableView: UITableView,
         _ stationSearchPresenter: StationSearchContract.stationSearchPresenter,
         _ stationSearchView: StationSearchView) {
        super.init()
        
        // Assign properties came from view
        self.stationsTableView = stationsTableView
        self.stationSearchPresenter = stationSearchPresenter
        self.stationSearchView = stationSearchView
        
        // Assign self as delegate and data soruce of table view
        self.stationsTableView?.delegate = self
        self.stationsTableView?.dataSource = self
        
        // Register xib cell to the table view
        registerCell()
        
    }
    
}

// Self related methods
extension StationsTableViewHelper {
    
    // MARK: - registerCell
    private func registerCell() {
        
        // Register station cell to the table view
        stationsTableView?.register(.init(nibName: "StationCell", bundle: nil), forCellReuseIdentifier: "StationCell")
        
    }
    
    // MARK: - setStationsInProvince
    func set(stationsInProvince: [Station]) {
        self.stationsInProvince = stationsInProvince
        
        // Animate reloding table view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.stationsTableView?.reloadData()
        }
    }
    
}

// MARK: - TABLE VIEW DELEGATE
extension StationsTableViewHelper: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deselect selected row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the station id of selected station
        guard let stationID = stationsInProvince[indexPath.row].id else { return }
        
        // Call did select station method in presenter sith selected
        // station id
        stationSearchPresenter.didSelectStation(stationSearchView!, with: stationID)
        
    }
    
}

// MARK: - TABLE VIEW DATAS SOURCE
extension StationsTableViewHelper: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stationsInProvince.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue station cell and initialized its ui components
        let stationCell = dequeueStationCell(tableView, indexPath)
        
        // Return dequeued and initialized station cell
        return stationCell
    }
    
}

// MARK: - Dequeue Station Cell
extension StationsTableViewHelper {
    
    private func dequeueStationCell(_ tableView: UITableView,
                                    _ indexPath: IndexPath) -> StationCell {
        
        var stationCellResult: StationCell?
        
        if let stationCell = tableView.dequeueReusableCell(withIdentifier: "StationCell") as? StationCell {
         
            // Initialize station cell helper
            let stationCellHelper = StationCellHelper(stationsInProvince, stationCell, indexPath)
            
            // Set AC/DC image view
            stationCellHelper.setACDCImageView()
            
            // Set station name label
            stationCellHelper.setStationNameLabel()
            
            // Set service hours label
            stationCellHelper.setServiceHoursLabel()
            
            // Set distance label
            stationCellHelper.setDistanceLabel()
            
            // Set avaliable socket number label
            stationCellHelper.setAvaliableSocketNumberLabel()
            
            stationCellResult = stationCell
        }
        
        // To prevent application crashing add the default initializer
        return stationCellResult ?? StationCell()
    }
    
}
