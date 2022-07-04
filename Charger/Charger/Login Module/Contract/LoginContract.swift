//
//  LoginContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 2.07.2022.
//

import Foundation

// MARK: - LOGIN CONTRACT
struct LoginContract {
    typealias loginView = LoginViewProtocol
    typealias loginInteractor = LoginInteractorProtocol
    typealias loginPresenter = LoginPresenterProtocol
    typealias loginEntity = LoginEntityProtocol
    typealias loginRouter = LoginRouterProtocol
}

// MARK: - LOGIN VIEW PROTOCOL
protocol LoginViewProtocol: AnyObject {
    // Self Related
    func showAlert(title: String, message: String)
    
    // Presenter Related
    var loginPresenter: LoginContract.loginPresenter! { get set }
}

// MARK: - LOGIN INTERACTOR PROTOCOL
protocol LoginInteractorProtocol: AnyObject {
    // Self Related
    func sendLoginRequest(_ email: String, _ deviceUDID: String)
    func fetchLoginResponse()
    
    // Presenter Related
    var loginPresenter: LoginContract.loginPresenter! { get set }
    
    // Entity Related
    var loginEntity: LoginContract.loginEntity! { get set }
    func didEncodeLoginRequest()
    func didDecodeLoginResponse()
}

// MARK: - LOGIN PRESENTER PROTOCOL
protocol LoginPresenterProtocol: AnyObject {
    // View Related
    var loginView: LoginContract.loginView? { get set }
    func didUserPressGirisYapButton(with email: String, and deviceUDID: String)
    
    // Interactor Related
    var loginInteractor: LoginContract.loginInteractor? { get set }
    func didLoginResponseReceived(_ loginResponse: LoginResponse)
    
    // Router Related
    var loginRouter: LoginContract.loginRouter? { get set }
}

// MARK: - LOGIN ENTITY PROTOCOL
protocol LoginEntityProtocol: AnyObject {
    // Self Related
    var encodedLoginRequest: Data? { get }
    var decodedLoginResponse: LoginResponse? { get }
    func encodeLoginRequest(_ email: String, _ deviceUDID: String)
    func decodeLoginResponse(_ data: Data)
    
    // Interactor Related
    var loginInteractor: LoginContract.loginInteractor? { get set }
}

// MARK: - LOGIN ROUTER PROTOCOL
protocol LoginRouterProtocol: AnyObject {
    // Self Related
    func navigateToAppointmentsPage()
    
    // View Related
    var loginView: LoginContract.loginView! { get set }
    
    // Presenter Related
    var loginPresenter: LoginContract.loginPresenter! { get set }
}
