//
//  HomeView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import UIKit

class HomeView: UIViewController, HomeContract.homeView {
    
    var isAppointmentsEmpty: Bool?
    
    var homePresenter: HomeContract.homePresenter?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// MARK: - SELF RELATED METHODS
extension HomeView {
    
    func displayPlaceholderView() {
        return
    }
    
    func displayTableView() {
        return
    }
    
    func updateAppointmentsTableView(with appointments: [AppointmentType]) {
        return
    }
    
}
