//
//  AppointmentDetailsContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import Foundation

// MARK: - Appointment Details Contract
struct AppointmentDetailsContract {
    typealias appointmentDetailsView = AppointmentDetailsViewProtocol
    typealias appointmentDetailsInteractor = AppointmentDetailsInteractorProtocol
    typealias appointmentDetailsPresenter = AppointmentDetailsPresenterProtocol
    typealias appointmentDetailsEntity = AppointmentDetailsEntityProtocol
    typealias appointmentDetailsRouter = AppointmentDetailsRouterProtocol
}

// MARK: - Appointment Details View Protocol
protocol AppointmentDetailsViewProtocol: AnyObject {
    // Self related
    var stationName: String?  { get set }
    func updateAppointmentDetailsTableView(with appointmentDetails: [AppointmentDetail])
    func reloadAppointmentDetailsTableView()
    
    // Presenter related
    var appointmentDetailsPresenter: AppointmentDetailsContract.appointmentDetailsPresenter? { get set }
    
}

// MARK: - Appointment Details Interactor Protocol
protocol AppointmentDetailsInteractorProtocol: AnyObject {
    // Self related
    var stationInfo: StationInfo? { get set }
    var appointmentRequest: AppointmentRequest? { get set }
    func sendAppointmentRequest()
    
    // Presenter related
    var appointmentDetailsPresenter: AppointmentDetailsContract.appointmentDetailsPresenter? { get set }
    
    // Entity related
    var appointmentDetailsEntity: AppointmentDetailsContract.appointmentDetailsEntity! { get set }
    func didEncodeAppointmentRequest()
}

// MARK: - Appointment Details Presenter Protocol
protocol AppointmentDetailsPresenterProtocol: AnyObject {
    // View related
    var appointmentDetailsView: AppointmentDetailsContract.appointmentDetailsView! { get set }
    func viewDidLoad()
    func didChangeSwitchState()
    func didSelectTimer(value: String)
    func didPressRandevuyuOnaylaButton(_ appointmentDetailsView: AppointmentDetailsView)
    
    // Interactor related
    var appointmentDetailsInteractor: AppointmentDetailsContract.appointmentDetailsInteractor! { get set }
    func didSendAppointmentRequest()
    
    // Router related
    var appointmentDetailsRouter: AppointmentDetailsContract.appointmentDetailsRouter! { get set }
}

// MARK: - Appointment Details Entity Protocol
protocol AppointmentDetailsEntityProtocol: AnyObject {
    // Self related
    var encodedAppointmentRequest: Data? { get set }
    func encodeAppointmentRequest(_ appointmentRequest: AppointmentRequest)
    
    // Interactor related
    var appointmentDetailsInteractor: AppointmentDetailsContract.appointmentDetailsInteractor? { get set }
}

// MARK: - Appointment Details Router Protocol
protocol AppointmentDetailsRouterProtocol: AnyObject {
    // Self related
    var homeView: HomeView? { get set }
    var appointmentDetailsView: AppointmentDetailsView? { get set }
    func navigateBackToHomePage()
}
