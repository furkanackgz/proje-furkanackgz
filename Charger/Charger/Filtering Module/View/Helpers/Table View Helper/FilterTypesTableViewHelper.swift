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
        filterTypesTableView?.register(.init(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionTableViewCell")
        
        // Register slider table view cell
        filterTypesTableView?.register(.init(nibName: "SliderTableViewCell", bundle: nil), forCellReuseIdentifier: "SliderTableViewCell")
        
    }
    
    // MARK: - registerHeaderView
    private func registerHeaderView() {
        
        // Register filter types table view header to the table view
        filterTypesTableView?.register(FilterTypesTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "FilterTypesTableViewHeader")
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Dequeue filter types table header view
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FilterTypesTableViewHeader") as! FilterTypesTableViewHeader
        
        // Assign section name
        headerView.headerTitle.text = filterTypes[section].type
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
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
            let sliderTableViewCell = dequeueSliderTableViewCell(tableView,
                                                                 indexPath)
            return sliderTableViewCell
            
        } else {
            
            // Dequeue collection table view cell
            let collectionTableViewCell = dequeueCollectionTableViewCell(tableView,
                                                                         indexPath)
            return collectionTableViewCell
            
        }
        
    }
    
}

// MARK: - Dequeue Slider Table View Cell
extension FilterTypesTableViewHelper {
    
    private func dequeueSliderTableViewCell(_ tableView: UITableView,
                                            _ indexPath: IndexPath) -> SliderTableViewCell {
        
        var sliderTableViewCell: SliderTableViewCell?
        
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell") as? SliderTableViewCell {
            
            // Set filter type to slider table view cell
            tableViewCell.filterType = filterTypes[indexPath.section].type
            
            // Set filter choice to slider table view cell
            tableViewCell.filterChoice = filterTypes[indexPath.section].filters[indexPath.row]
            
            // Assign filtering presenter
            tableViewCell.filteringPresenter = filteringPresenter
            
            sliderTableViewCell = tableViewCell
        }
        
        // To prevent application crashing add the default initializer
        return sliderTableViewCell ?? SliderTableViewCell()
    }
    
}

// MARK: - Dequeue Collection Table View Cell
extension FilterTypesTableViewHelper {
    
    private func dequeueCollectionTableViewCell(_ tableView: UITableView,
                                                _ indexPath: IndexPath) -> CollectionTableViewCell {
        
        var collectionTableViewCell: CollectionTableViewCell?
        
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as? CollectionTableViewCell {
            
            // Take filter type out of filter types
            let filterType = filterTypes[indexPath.section]
            
            // Set filter type to the collection view cell
            tableViewCell.set(filterType)
            
            // Assign filtering presenter
            tableViewCell.filteringPresenter = filteringPresenter
            
            collectionTableViewCell = tableViewCell
        }
        
        // To prevent application crashing add the default initializer
        return collectionTableViewCell ?? CollectionTableViewCell()
    }
    
}
