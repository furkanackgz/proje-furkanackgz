//
//  ProfileContract.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 9.07.2022.
//

import Foundation

// MARK: - PROFILE CONTRACT
struct ProfileContract {
    typealias profileView = ProfileViewProtocol
    typealias profileInteractor = ProfileInteractorProtocol
    typealias profilePresenter = ProfilePresenterProtocol
    typealias profileRouter = ProfileRouterProtocol
}

// MARK: - PROFILE VIEW PROTOCOL
protocol ProfileViewProtocol: AnyObject {
    // Self related
    func setProfileViewData(with email: String, and deviceID: String)
    func showAlert(with title: String, and message: String)
    
    // Presenter related
    var profilePresenter: ProfileContract.profilePresenter? { get set }
}

// MARK: - PROFILE INTERACTOR PROTOCOL
protocol ProfileInteractorProtocol: AnyObject {
    // Self related
    func sendLogoutRequest(_ profileView: ProfileView)
    
    // Presenter related
    var profilePresenter: ProfileContract.profilePresenter? { get set }
}

// MARK: - PROFILE PRESENTER PROTOCOL
protocol ProfilePresenterProtocol: AnyObject {
    // View related
    var profileView: ProfileContract.profileView! { get set }
    func viewDidLoad()
    func didPressCikisYapButton(_ profileView: ProfileView)
    
    // Interactor related
    var profileInteractor: ProfileContract.profileInteractor! { get set }
    func didReceiveLogoutResponse(_ succeed: Bool, _ profileView: ProfileView)
    
    // Router related
    var profileRouter: ProfileContract.profileRouter! { get set }
    
}

// MARK: - PROFILE ROUTER PROTOCOL
protocol ProfileRouterProtocol: AnyObject {
    // Self related
    func navigateToLoginPage(_ profileView: ProfileView)
}
