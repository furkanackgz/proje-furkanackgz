//
//  ProvinceSearchContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import Foundation

// MARK: - PROVINCE SEARCH CONTRACT
struct ProvinceSearchContract {
    typealias provinceSearchView = ProvinceSearchViewProtocol
    typealias provinceSearchInteractor = ProvinceSearchInteractorProtocol
    typealias provinceSearchPresenter = ProvinceSearchPresenterProtocol
    typealias provinceSearchRouter = ProvinceSearchRouterProtocol
}

// MARK: - PROVINCE SEARCH VIEW PROTOCOL
protocol ProvinceSearchViewProtocol: AnyObject {
    // Self related
    func updateProvincesTableView(with provinces: [String], and searchText: String)
    func displayPlaceholderView()
    func displayTableView(_ searchText: String)
    
    // Presenter related
    var provinceSearchPresenter: ProvinceSearchContract.provinceSearchPresenter? { get set }
    var isPlaceholderViewHidden: Bool? { get }
}

// MARK: - PROVINCE SEARCH INTERACTOR PROTOCOL
protocol ProvinceSearchInteractorProtocol: AnyObject {
    // Self related
    var provinces: [String]? { get set }
    var filteredProvinces: [String]? { get set }
    
    // Presenter related
    var provinceSearchPresenter: ProvinceSearchContract.provinceSearchPresenter? { get set }
    func fetchProvinces()
    func updateFilteredProvinces(with provinces: [String],
                                 and searchText: String)
}

// MARK: - PROVINCE SEARCH PRESENTER PROTOCOL
protocol ProvinceSearchPresenterProtocol: AnyObject {
    // View related
    var provinceSearchView: ProvinceSearchContract.provinceSearchView! { get set }
    func viewDidLoad()
    func didEditSearchText(_ searchText: String)
    func didSelectProvince(_ provinceName: String,
                           _ provinceSearchView: ProvinceSearchView)
    
    // Interactor related
    var provinceSearchInteractor: ProvinceSearchContract.provinceSearchInteractor! { get set }
    func didFetchProvinces()
    func didUpdateFilteredProvinces(with searchText: String)
    
    // Router related
    var provinceSearchRouter: ProvinceSearchContract.provinceSearchRouter! { get set }
}

// MARK: - PROVINCE SEARCH ROUTER PROTOCOL
protocol ProvinceSearchRouterProtocol: AnyObject {
    // Self related
    var homeView: HomeView? { get set }
    func navigateToStationSearchPage(_ provinceName: String,
                                     _ provinceSearchView: ProvinceSearchView)
}

