//
//  PickDateAndTimeContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 15.07.2022.
//

import Foundation

// MARK: - PickDateAndTimeContract
struct PickDateAndTimeContract {
    typealias pickDateAndTimeView = PickDateAndTimeViewProtocol
    typealias pickDateAndTimeInteractor = PickDateAndTimeInteractorProtocol
    typealias pickDateAndTimePresenter = PickDateAndTimePresenterProtocol
    typealias pickDateAndTimeEntity = PickDateAndTimeEntityProtocol
    typealias pickDateAndTimeRouter = PickDateAndTimeRouterProtocol
}

// MARK: - PickDateAndTimeViewProtocol
protocol PickDateAndTimeViewProtocol: AnyObject {
    // Self related
    var stationName: String? { get set }
    func set(sockets: [SocketInfo])
    
    //Presenter related
    var pickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter? { get set }
}

// MARK: - PickDateAndTimeInteractorProtocol
protocol PickDateAndTimeInteractorProtocol: AnyObject {
    // Self related
    var stationInfo: StationInfo? { get set }
    var appointmentRequest: AppointmentRequest? { get set }
    var stationID: Int? { get set }
    var date: String? { get set }
    func fetchStationInfo(with stationID: Int, and date: String)
    func setAppointmentRequest(with appointmentRequest: AppointmentRequest)
    
    // Presenter related
    var pickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter? { get set }
    
    // Entity related
    var pickDateAndTimeEntity: PickDateAndTimeContract.pickDateAndTimeEntity! { get set }
    func didDecodeStationInfo()
    
}

// MARK: - PickDateAndTimePresenterProtocol
protocol PickDateAndTimePresenterProtocol: AnyObject {
    // View related
    var pickDateAndTimeView: PickDateAndTimeContract.pickDateAndTimeView! { get set }
    func viewDidLoad()
    func didSelectTimeSlot(_ stationID: Int, _ socketID: Int,
                           _ timeSlot: String, _ appointmentDate: String)
    func didPressDevamEtButton(_ pickDateAndTimeView: PickDateAndTimeView)
    
    // Interactor related
    var pickDateAndTimeInteractor: PickDateAndTimeContract.pickDateAndTimeInteractor! { get set }
    func didFetchStationInfo()
    
    // Router related
    var pickDateAndTimeRouter: PickDateAndTimeContract.pickDateAndTimeRouter! { get set }
}

// MARK: - PickDateAndTimeEntityProtocol
protocol PickDateAndTimeEntityProtocol: AnyObject {
    // Self related
    var decodedStationInfo: StationInfo? { get set }
    func decodeStationInfoResponse(_ data: Data)
    
    // Interactor related
    var pickDateAndTimeInteractor: PickDateAndTimeContract.pickDateAndTimeInteractor? { get set }
}

// MARK: - PickDateAndTimeRouterProtocol
protocol PickDateAndTimeRouterProtocol: AnyObject {
    // Self related
    func navigateToAppointmentDetailsPage(_ pickDateAndTimeView: PickDateAndTimeView,
                                          _ stationInfo: StationInfo,
                                          _ appointmentRequest: AppointmentRequest)
}
