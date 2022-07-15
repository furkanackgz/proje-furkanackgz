//
//  FilteringContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 14.07.2022.
//

import Foundation

// MARK: - Filtering Contract
struct FilteringContract {
    typealias filteringView = FilteringViewProtocol
    typealias filteringInteractor = FilteringInteractorProtocol
    typealias filteringPresenter = FilteringPresenterProtocol
    typealias filteringEntity = FilteringEntityProtocol
    typealias filteringRouter = FilteringRouterProtocol
}

// MARK: - Filtering View Protocol
protocol FilteringViewProtocol: AnyObject {
    // Self related
    func setFilterTypesTableView(with filterTypes: [FilterType])
    func reloadFilterTypesTableView()
    
    // Presenter related
    var filteringPresenter: FilteringContract.filteringPresenter? { get set }
}

// MARK: - Filtering Interactor Protocol
protocol FilteringInteractorProtocol: AnyObject {
    // Self related
    var filterTypes: [FilterType] { get set}
    var filterChoices: [Filter] { get set }
}

// MARK: - Filtering Presenter Protocol
protocol FilteringPresenterProtocol: AnyObject {
    // View related
    var filteringView: FilteringContract.filteringView! { get set }
    func viewDidLoad()
    func checkWhetherFilterCellSelected(with filterType: String,
                                        and filterChoice: String) -> Bool
    func checkWhetherSliderValueSet(with filterType: String,
                                    and filterChoice: String) -> Int
    func appendFilterCell(with filterType: String, and filterChoice: String)
    func removeFilterCell(with filterType: String, and filterChoice: String)
    func updateSliderValue(with filterType: String, and filterChoice: Int)
    func didPressFilterButton(_ filteringView: FilteringView)
    func didPressTemizleBarButton()
    
    // Interactor related
    var filteringInteractor: FilteringContract.filteringInteractor! { get set }
    
    // Router related
    var filteringRouter: FilteringContract.filteringRouter! { get set }
}

// MARK: - Filtering Entity Protocol
protocol FilteringEntityProtocol: AnyObject {
    
}

// MARK: - Filtering Router Protocol
protocol FilteringRouterProtocol: AnyObject {
    // Self related
    func navigateToStationSearchPage(_ filteringView: FilteringView)
}
