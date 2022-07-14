//
//  FilterTypesTableViewHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 14.07.2022.
//

import UIKit

class FilterTypesTableViewHelper: NSObject {
    
    private var filterTypes = [FilterType]()
    
    private weak var filterTypesTableView: UITableView?
    
    private var filteringPresenter: FilteringContract.filteringPresenter!
    
    init(_ filterTypesTableView: UITableView,
         _ filteringPresenter: FilteringContract.filteringPresenter) {
        
        super.init()
        
        // Assign properties came from view layer
        self.filterTypesTableView = filterTypesTableView
        self.filteringPresenter = filteringPresenter
        
        // Assign self as delegate and data source of table view
        self.filterTypesTableView?.delegate = self
        self.filterTypesTableView?.dataSource = self
        
        // Register cells
        registerCells()
        
        // Register header view
        registerHeaderView()
        
    }
    
}

// Self related methods
extension FilterTypesTableViewHelper {
    
    // MARK: - registerCells
    private func registerCells() {
        
        // Register collection table view cell
        
        
        // Register slider table view cell
        
        
    }
    
    // MARK: - registerHeaderView
    private func registerHeaderView() {
        
        // Register filter types table view header to the table view
        
        
    }
    
    // MARK: - setFilterTypes
    func set(_ filterTypes: [FilterType]) {
        self.filterTypes = filterTypes
        
        // Animate reloding table view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.filterTypesTableView?.reloadData()
        }
        
    }
    
}

// MARK: TABLE VIEW DELEGATE
extension FilterTypesTableViewHelper: UITableViewDelegate {
    
    // viewForHeaderInSection
    
    
    // heightForHeaderInSection
    
}

// MARK: TABLE DATA SOURCE
extension FilterTypesTableViewHelper: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTypes[section].filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         Decide which type of table view cell will be initialized
         depending on cell's type value.
         */
        if filterTypes[indexPath.section].type == "Uzaklık (km)" {
            
            // Dequeue slider table view cell
            
            
        } else {
            
            // Dequeue collection table view cell
            
            
        }
        
        return UITableViewCell()
    }
    
}

// MARK: - Dequeue Collection Table View Cell
extension FilterTypesTableViewHelper {
    
    
    
}

// MARK: - Dequeue Slider Table View Cell
extension FilterTypesTableViewHelper {
    
    
    
}
