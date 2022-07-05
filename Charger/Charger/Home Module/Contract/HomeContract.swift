//
//  HomeContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import Foundation

// MARK: - HOME CONTRACT
struct HomeContract {
    typealias homeView = HomeViewProtocol
    typealias homeInteractor = HomeInteractorProtocol
    typealias homePresenter = HomePresenterProtocol
    typealias homeEntity = HomeEntityProtocol
    typealias homeRouter = HomeRouterProtocol
}

// MARK: - HOME VIEW PROTOCOL
protocol HomeViewProtocol: AnyObject {
    // Self related
    var isAppointmentsEmpty: Bool? { get set }
    func displayPlaceholderView()
    func displayTableView()
    func updateAppointmentsTableView(with appointments: [AppointmentType])
    
    // Presenter related
    var homePresenter: HomeContract.homePresenter? { get set }
}

// MARK: - HOME INTERACTOR PROTOCOL
protocol HomeInteractorProtocol: AnyObject {
    // Self related
    var appointmentsResponse: [Appointment]? { get set }
    func fetchAppointmentsResponse()
    
    // Presenter related
    var homePresenter: HomeContract.homePresenter? { get set }
    func didDecodeAppointmentsResponse()
    func updateAppointments(_ updatedAppointments: [Appointment])
    
    // Entity related
    var homeEntity: HomeContract.homeEntity! { get set }
    
}

// MARK: - HOME PRESENTER PROTOCOL
protocol HomePresenterProtocol: AnyObject {
    // Self related
    func prepareAppointmentsTableViewData(_ appointmentsResponse:
                                          [Appointment]) -> [Appointment]
    
    // View related
    var homeView: HomeContract.homeView! { get set }
    func viewWillAppear()
    func displayPlaceholderOrTableView()
    func deleteAppointment(with appointmentID: Int,
                           in appointments: [AppointmentType])
    // Interactor related
    var homeInteractor: HomeContract.homeInteractor! { get set }
    func didFetchAppointmentsResponse()
    func didUpdateAppointments()
    
    // Router related
    var homeRouter: HomeContract.homeRouter! { get set }
}

// MARK: - HOME ENTITY PROTOCOL
protocol HomeEntityProtocol: AnyObject {
    // Self related
    var decodedAppointmentsResponse: [Appointment]? { get set }
    func decodeAppointments(response: Data)
    
    // Interactor related
    var homeInteractor: HomeContract.homeInteractor?  { get set }
}

// MARK: - HOME ROUTER PROTOCOL
protocol HomeRouterProtocol: AnyObject {
    // Self related
    func navigateToProfilePage(_ homeView: HomeView)
    func navigateToCitySearchPage(_ homeView: HomeView)
    
    // View related
    var homeView: HomeContract.homeView! { get set }
    
}
