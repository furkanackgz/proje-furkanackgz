//
//  FilteringPresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 15.07.2022.
//

import Foundation

class FilteringPresenter: FilteringContract.filteringPresenter {
    
    // MARK: - Properties
    var filteringView: FilteringContract.filteringView!
    
    var filteringInteractor: FilteringContract.filteringInteractor!
    
    var filteringRouter: FilteringContract.filteringRouter!
    
}

// Self related
extension FilteringPresenter {
    
    // MARK: - createFilterTypes
    private func createFilterTypes() -> [FilterType] {
        
        // Create filter types array which will be display
        // in filter types table view
        let filterTypes: [FilterType] = [
            .init(type: "Cihaz Tipi", filters: ["AC","DC"]),
            .init(type: "Soket Tipi", filters: ["Type-2", "CSC", "CHAdeMO"]),
            .init(type: "Uzaklık (km)", filters: [""]),
            .init(type: "Hizmetler", filters: ["Otopark", "Büfe", "Wi-Fi"])
        ]
        
        return filterTypes
    }
    
    // MARK: - checkWhetherFilterChoicesContains
    private func checkWhetherFilterChoicesContains(_ filterType: String,
                                                   _ filterChoice: String) -> Bool {
        
        var contains: Bool = false
        
        // Take filter choices came from station seach page
        let filterChoices = filteringInteractor.filterChoices
        
        var containsFilterType: Bool = false
        
        // Check whether filter choices contains particular filter type
        filterChoices.forEach { filter in
            
            // If it contains
            if filter.filterType == filterType {
                // Assign true
                containsFilterType = true
                
            }
            
        }
        
        var containsFilterChoice: Bool = false
        
        // Check whether filter choices contains particular filter choice
        filterChoices.forEach { filter in
            
            // If it contains
            if (filter.filterChoice as! String) == filterChoice {
                // Assign true
                containsFilterChoice = true
                
            }
            
        }
        
        // Concatenate containsFilterType and containsFilterChoice
        contains = containsFilterType && containsFilterChoice
        
        return contains
    }
    
    // MARK: - checkWhetherFilterChoicesContainsSliderValue
    private func checkWhetherFilterChoicesContainsSliderValue(with filterType: String) -> Int {
        
        var sliderValue: Int = 15
        
        // Take filter choices came from station seach page
        let filterChoices = filteringInteractor.filterChoices
        
        // Check whether filter choices contains particular filter type
        filterChoices.forEach { filter in
            
            // If it contains
            if filter.filterType == filterType {
                
                // Assign it's choice value
                sliderValue = (filter.filterChoice as! Int)
                
            }
            
        }
        
        return sliderValue
    }
    
}

// View related
extension FilteringPresenter {
    
    // MARK: - viewDidLoad
    func viewDidLoad() {
        
        // Create filter types array
        let filterTypes = createFilterTypes()
        
        // Set filter types to filter types table
        // view
        filteringView.setFilterTypesTableView(with: filterTypes)
        
    }
    
    // MARK: - checkWhetherFilterCellSelected
    func checkWhetherFilterCellSelected(with filterType: String,
                                        and filterChoice: String) -> Bool {
        
        // Check whether it is selected by checking whether filter choices contains it
        let selected = checkWhetherFilterChoicesContains(filterType,
                                                         filterChoice)
        return selected
    }
    
    // MARK: - checkWhetherSliderValueSet
    func checkWhetherSliderValueSet(with filterType: String,
                                    and filterChoice: String) -> Int {
        // Check whether slider value already set by checking whether
        // filter choices contains it
        let sliderValue = checkWhetherFilterChoicesContainsSliderValue(with: filterType)
        
        return sliderValue
    }
    
    // MARK: - appendFilterCell
    func appendFilterCell(with filterType: String,
                          and filterChoice: String) {
        
        // Create filter choice with the received parameters
        let filterChoice = Filter(filterType: filterType,
                                  filterChoice: filterChoice)
        
        // Take filter choices from interactor layer
        var filterChoices = filteringInteractor.filterChoices
        
        // Assign filter choice to the filter choices
        filterChoices.append(filterChoice)
        
        // Reload filter types table view
        filteringView.reloadFilterTypesTableView()
        
    }
    
    // MARK: - removeFilterCell
    func removeFilterCell(with filterType: String,
                          and filterChoice: String) {
        
        // Take filter choices from interactor layer
        var filterChoices = filteringInteractor.filterChoices
        
        // Remove filter choice in filter choices array
        filterChoices.removeAll { filter in
            
            // If filter type and choice is the same with any of the
            // filter in filter choices array
            (filter.filterType == filterType) && ((filter.filterChoice as! String) == filterChoice)
            
        }
        
        // Reload filter types table view
        filteringView.reloadFilterTypesTableView()
        
    }
    
    // MARK: - updateSliderValue
    func updateSliderValue(with filterType: String,
                           and filterChoice: Int) {
        
        // Take filter choices from interactor layer
        let filterChoices = filteringInteractor.filterChoices
        
        filterChoices.forEach { filter in
            
            // Convert constant filter to variable filter
            var filter = filter
            
            // If slider filter type is found
            if filter.filterType == filterType {
                
                // Assing new filter choice slider value
                filter.filterChoice = filterChoice
                
            }
            
        }
        
    }
    
    // MARK: - didPressFilterButton
    func didPressFilterButton(_ filteringView: FilteringView) {
        // Move back to station search page
        filteringRouter.navigateToStationSearchPage(filteringView)
    }
    
    // MARK: - didPressTemizleBarButton
    func didPressTemizleBarButton() {
        
        // Take filter choices array from interactor layer
        var filterChoices = filteringInteractor.filterChoices
        
        // Remove all the elements in filter choices
        filterChoices.removeAll(keepingCapacity: false)
        
        // Reload filter types table view
        filteringView.reloadFilterTypesTableView()
        
    }
    
}
