//
//  StationSearchPresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 13.07.2022.
//

import Foundation

class StationSearchPresenter: StationSearchContract.stationSearchPresenter {
    
    // MARK: - Properties
    var stationSearchView: StationSearchContract.stationSearchView!
    
    var stationSearchInteractor: StationSearchContract.stationSearchInteractor!
    
    var stationSearchRouter: StationSearchContract.stationSearchRouter!
    
}

// Self related methods
extension StationSearchPresenter {
    
    // MARK: - displayOrHideFiltersCollectionView
    private func displayOrHideFiltersCollectionView() {
        
        // Take filter choices array from interaction layer
        let filterChoices = stationSearchInteractor.filterChoices
        
        // Check if filter choices array is empty
        if filterChoices.isEmpty {
            
            // Hide filters collection view
            stationSearchView.hideFiltersCollectionView()
            
        } else {
            
            // Take the filter choices from interactor
            let filterChoices = stationSearchInteractor.filterChoices
            
            // Set filter choices before displaying them in
            // collection view
            stationSearchInteractor.setFilterChoices(with: filterChoices)
            
            // Display filters collection view
            stationSearchView.displayFiltersCollectionView()
            
        }
        
    }
    
    // MARK: - filterToStationsInProvince
    private func filterToStationsInProvince() -> [Station] {
        
        // Take all stations from interactor layer
        let allStations = stationSearchInteractor.allStations
        
        // Initialize stations in province property
        var stationsInProvince = [Station]()
        
        // Take province in view layer assigned from
        // province search module and unwrap it
        guard let province = stationSearchView.province else { return [] }
        
        // Filter all stations to get the only ones which
        // are in the province that is provided from
        // province search module
        stationsInProvince = allStations.filter {
            $0.geoLocation?.province! == province
        }
        
        // If distance info came from server
        if let _ = allStations.first?.distanceInKM {
            
            // Sort stations also in ascending order by their distances
            let sortedStationsInProvince = stationsInProvince.sorted(by: {
                $0.distanceInKM! < $1.distanceInKM!
            })
            
            // Assign sorted stations back
            stationsInProvince = sortedStationsInProvince
        }
        
        // Return filtered stations
        return stationsInProvince
        
    }
    
    // MARK: - getTodaysDate
    private func getTodaysDate() -> String {
        
        // Take the current date of today
        let date = Date()
        
        // Create iso8601 date formatter
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withFullDate]
        
        // Convert it to string with spesified option
        let result = iso8601DateFormatter.string(from: date)
        
        return result
        
    }
    
    // MARK: - filterStationsInProvince
    private func filterStationsInProvince(with searchText: String) -> [Station] {
        
        // Take stations in province from interactor
        let stationsInProvince = stationSearchInteractor.stationsInProvince
        
        // Initialize filtered stations in province which will be
        // sent to interactor layer later on
        var filteredStationsInProvince = [Station]()
        
        // If user didn't enter any character to
        // the search text
        if searchText == "" {
            
            // Assign all stations since there is no filtered
            // search text
            filteredStationsInProvince = stationsInProvince
            
        } else {
            
            // Assign stations which contains search text in its
            // province name to the filtered stations in province
            filteredStationsInProvince = stationsInProvince.filter({ station in
                station.stationName!.localizedLowercase.contains(searchText.localizedLowercase)
            })
            
        }
        
        // Return filtered stations in province
        return filteredStationsInProvince
        
    }
    
    // MARK: - filterOutSpecifiedFilterChoice
    private func filterOutSpecifiedFilterChoice(with filterChoice: Filter) -> [Filter] {
        
        // Take the filtered choices from interactor layer
        let filterChoices = stationSearchInteractor.filterChoices
        
        // Cast filter choice of parameter as string
        let filterChoice =  filterChoice.filterChoice as! String
        
        // Filter out the specified filter choice from
        // filter choices
        let filteredFilterChoices = filterChoices.filter {
            
            // Cast filter choice as string of each filter
            let stringFilterChoice = $0.filterChoice as! String
            
            // Compare each filter's filter choice value and
            // take the ones who are not the same
            return stringFilterChoice != filterChoice
            
        }
        
        // Return filtered filter choices
        return filteredFilterChoices
        
    }
    
}

// View related methods
extension StationSearchPresenter {
    
    // MARK: - viewDidLoad
    func viewDidLoad() {
        
        // Fetch all stations
        stationSearchInteractor.fetchAllStations()
        
    }
    
    // MARK: - viewWillAppear
    func viewWillAppear() {
        
        // Check if filters are set
        displayOrHideFiltersCollectionView()
        
    }
    
    // MARK: - didEditSearchText
    func didEditSearchText(with searchText: String) {
        
        // Filter stations in province with search text
        let filteredStationsInProvince = filterStationsInProvince(with: searchText)
        
        // Send filtered stations in province to interactor layer
        stationSearchInteractor.setFilteredStationsInProvince(with: filteredStationsInProvince)
        
    }
    
    // MARK: - didSelectStation
    func didSelectStation(_ stationSearchView: StationSearchView, with stationID: Int) {
        
        // Get todays date in iso-8601 format
        let date = getTodaysDate()
        
        // Navigate to station sockets info page
        stationSearchRouter.navigateToStationSocketsInfoPage(stationSearchView, with: stationID, and: date)
    }
    
    // MARK: - didPressCancelFilterButton
    func didPressCancelFilterButton(with filterChoice: Filter) {
        
        // Filter out specified filter choice from filter choices
        let filteredFilterChoices = filterOutSpecifiedFilterChoice(with: filterChoice)
        
        // Set filtered filter choice to filter choices in
        // interactor layer
        stationSearchInteractor.setFilterChoices(with: filteredFilterChoices)
        
    }
    
    // MARK: - didPressFilterBarButton
    func didPressFilterBarButton(_ stationSearchView: StationSearchView) {
        
        // Take filter choices
        let filterChoices = stationSearchInteractor.filterChoices
        
        // Navigate to filtering page
        stationSearchRouter.navigateToFilteringPage(stationSearchView,
                                                    with: filterChoices)
    }
    
}

// Interactor related methods
extension StationSearchPresenter {
    
    // MARK: - didFetchAllStations
    func didFetchAllStations() {
        
        // Filtere stations which are in the province
        let stationsInProvince = filterToStationsInProvince()
        
        // Set filtered stations to stationsInProvince in interactor
        stationSearchInteractor.setStationsInProvince(with: stationsInProvince)
        
    }
    
    // MARK: - didSetStationsInProvince
    func didSetStationsInProvince() {
        
        // Take stations in province from interactor layer
        let stationsInProvince = stationSearchInteractor.stationsInProvince
        
        // If stations in province are more than 3 only take 3 of them, otherwise
        // take all whatever inside
        let restrictedStationsInProvince = Array(stationsInProvince.prefix(3))
        
        DispatchQueue.main.async { [weak self] in
            
            // Update station table view with restricted stations in province
            self?.stationSearchView.updateStationsTableView(restrictedStationsInProvince)
            
        }
        
    }
    
    // MARK: - didSetFilteredStationsInProvince
    func didSetFilteredStationsInProvince() {
        
        // Take filtered stations in province from interactor layer
        let filteredStationsInProvince = stationSearchInteractor.filteredStationsInProvince
        
        // If filtered stations in province are more than 3 only take 3 of them,
        // otherwise take all whatever inside
        let restrictedFilteredStationsInProvince = Array(filteredStationsInProvince.prefix(3))
        
        DispatchQueue.main.async { [weak self] in
            
            // Update station table view with restricted filtered stations in province
            self?.stationSearchView.updateStationsTableView(restrictedFilteredStationsInProvince)
            
        }
        
    }
    
    // MARK: - didSetFilterChoices
    func didSetFilterChoices() {
        
        // Take filter choices from interactor layer
        let filterChoices = stationSearchInteractor.filterChoices
        
        DispatchQueue.main.async { [weak self] in
            
            // Update filters collection view
            self?.stationSearchView.updateFiltersCollectionView(with: filterChoices)
            
        }
        
    }
    
}
