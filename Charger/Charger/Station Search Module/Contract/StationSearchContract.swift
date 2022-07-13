//
//  StationSearchContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 12.07.2022.
//

import Foundation

// MARK: - STATION SEARCH CONTRACT
struct StationSearchContract {
    typealias stationSearchView = StationSearchViewProtocol
    typealias stationSearchInteractor = StationSearchInteractorProtocol
    typealias stationSearchPresenter = StationSearchPresenterProtocol
    typealias stationSearchEntity = StationSearchEntityProtocol
    typealias stationSearchRouter = StationSearchRouterProtocol
}

// MARK: - STATION SEARCH VIEW PROTOCOL
protocol StationSearchViewProtocol: AnyObject {
    // Self related
    var province: String? { get set }
    func updateStationsTableView(_ stationsInProvince: [Station])
    func updateFiltersCollectionView(with filterChoices: [Filter])
    func displayFiltersCollectionView()
    func hideFiltersCollectionView()
    
    // Presenter related
    var stationSearchPresenter: StationSearchContract.stationSearchPresenter? { get set }
}

// MARK: - STATION SEARCH INTERACTOR PROTOCOL
protocol StationSearchInteractorProtocol: AnyObject {
    // Self related
    var allStations: [Station] { get set }
    var stationsInProvince: [Station] { get set }
    var filteredStationsInProvince: [Station] { get set }
    var filterChoices: [Filter] { get set }
    func fetchAllStations()
    
    // Presenter related
    var stationSearchPresenter: StationSearchContract.stationSearchPresenter? { get set }
    func setStationsInProvince(with stationsInProvince: [Station])
    func setFilterChoices(with filterChoices: [Filter])
    
    // Entity related
    var stationsSearchEntity: StationSearchContract.stationSearchEntity! { get set }
    func didDecodeAllStationsResponse()
    
}

// MARK: - STATION SEARCH PRESENTER PROTOCOL
protocol StationSearchPresenterProtocol: AnyObject {
    // View related
    var stationSearchView: StationSearchContract.stationSearchView! { get set }
    func viewDidLoad()
    func viewWillAppear()
    func didEditSearchText(with searchText: String)
    func didSelectStation(_ stationSearchView: StationSearchView,
                          with stationID: Int)
    func didPressCancelFilterButton(with filterChoice: Filter)
    func didPressFilterBarButton(_ stationSearchView: StationSearchView)
    
    // Interactor related
    var stationSearchInteractor: StationSearchContract.stationSearchInteractor! { get set }
    func didFetchAllStations()
    func didSetStationsInProvince()
    func didSetFilterChoices()
    
    // Router related
    var stationSearchRouter: StationSearchContract.stationSearchRouter! { get set }
    
}

// MARK: - STATION SEARCH ENTITY PROTOCOL
protocol StationSearchEntityProtocol: AnyObject {
    // Self related
    var decodedAllStationsResponse: [Station] { get set }
    func decodeAllStationsResponse(_ data: Data)
    
    // Interactor related
    var stationSearchInteractor: StationSearchContract.stationSearchInteractor? { get set }
}

// MARK: - STATION SEARCH ROUTER PROTOCOL
protocol StationSearchRouterProtocol: AnyObject {
    // Self related
    func navigateToFilteringPage(_ stationSearchView: StationSearchView,
                                 with filterChoices: [Filter])
    func navigateToStationSocketsInfoPage(_ stationSearchView: StationSearchView,
                                          with stationID: Int,
                                          and date: String)
}

