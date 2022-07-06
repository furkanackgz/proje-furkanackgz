//
//  HomeView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import UIKit

class HomeView: UIViewController, HomeContract.homeView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var appointmentsTableView: UITableView!
    @IBOutlet weak var randevuOlusturButton: UIButton!
    
    private var appointmentsTableViewHelper: AppointmentsTableViewHelper!
    
    var isAppointmentsEmpty: Bool?
    
    var homePresenter: HomeContract.homePresenter?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call setupUI method to prepare UI components
        setupUI()
        
        // Assign Table View Helper
        appointmentsTableViewHelper = .init(appointmentsTableView,
                                            homePresenter!)
        
        // Call viewDidLoad method of presenter to fetch data
        homePresenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePresenter?.viewWillAppear()
    }
    
    @IBAction func didPressRandevuOlusturButton(_ sender: Any) {
        homePresenter?.didPressRandevuOlusturButton()
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

// MARK: - Setting up ui components
extension HomeView {
    
    /**
     SetupUI method does setup UI as its name implies.
     It prepares UI components to conform to zeplin guideline
     of the project.
     
     -returns: None
     */
    // MARK: - setupUI
    private func setupUI() {
        // Set navigation bar
        setNavigationBar()
        
        // Set background colors of views
        setViews()
        
        // Set table view background color
        setTableViewBackground()
        
        // Set randevu olustur button's forground
        setRandevuOlusturButton()
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        // Set navigation title
        setNavigationTitle()
        
        // Set navigation profile button
        setNavigationProfileButton()
    }
    
    // MARK: - setNavigationTitle
    private func setNavigationTitle() {
        // Set navigation title as attributed string
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Randevular"
    }
    
    // MARK: - setNavigationProfileButton
    private func setNavigationProfileButton() {
        var barProfileLogo = ThemeManager.image.logoProfileButton
        barProfileLogo = barProfileLogo?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: barProfileLogo,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didPressProfileBarButton))
    }
    
    // MARK: - setViews
    private func setViews() {
        // Set super view's background color
        view.backgroundColor = ThemeManager.color.background
        
        // Set super view's background color
        containerView.backgroundColor = ThemeManager.color.background
    }
    
    // MARK: - setTableViewBackgorund
    private func setTableViewBackground() {
        appointmentsTableView.tintColor = ThemeManager.color.background
        appointmentsTableView.backgroundColor = ThemeManager.color.background
    }
    
    // MARK: - setRandevuOlusturButton
    private func setRandevuOlusturButton() {
        randevuOlusturButton.titleLabel?.isHidden = true
        randevuOlusturButton.configuration = .plain()
        randevuOlusturButton.setImage(ThemeManager.image.buttonRandevuOlustur,
                                      for: .normal)
    }
    
}

// MARK: - @objc methods
extension HomeView {
    
    @objc private func didPressProfileBarButton() {
        homePresenter?.didPressProfileBarButton()
    }
    
}
