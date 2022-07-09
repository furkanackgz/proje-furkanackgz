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
    private var placeholderView: PlaceholderView?
    
    // IsAppointmentsEmpty variable checks appointments
    // array which feed the appointment table view for
    // notifying presenter to display either placeholder
    // or table view according to emptiness of the array
    var isAppointmentsEmpty: Bool {
        get{
            appointmentsTableViewHelper.isAppointmentsEmpty
        }
    }
    
    var homePresenter: HomeContract.homePresenter?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call setupUI method to prepare UI components
        setupUI()
        
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        // Call viewWillAppear method of presenter to fetch data
        homePresenter?.viewWillAppear()
    }
    
    // MARK: - didPressRandevuOlusturButton
    @IBAction func didPressRandevuOlusturButton(_ sender: Any) {
        homePresenter?.didPressRandevuOlusturButton()
    }
    
}

// MARK: - SELF RELATED METHODS
extension HomeView {
    
    // MARK: - displayPlaceholderView
    func displayPlaceholderView() {
        
        // Animate displaying placeholder view for
        // better user experience
        UIView.animate(withDuration: 1, delay: 1) { [weak self] in
            // Expose placeholder view
            self?.placeholderView?.isHidden = false
            
            // Hide table view
            self?.appointmentsTableView.isHidden = true
        }
        
    }
    
    // MARK: - displayTableView
    func displayTableView() {
        
        // Animate displaying table view for
        // better user experience
        UIView.animate(withDuration: 1, delay: 1) { [weak self] in
            // Expose table view
            self?.appointmentsTableView.isHidden = false
            
            // Hide placeholder view
            self?.placeholderView?.isHidden = true
        }
        
    }
    
    // MARK: - updateAppointmentsTableView
    func updateAppointmentsTableView(with appointments: [AppointmentType]) {
        // Send it to table view helper to display them in table view
        appointmentsTableViewHelper.set(appointments: appointments)
        
        // Call display placeholder or tableView method for
        // picking either placeholder or table view to display
        homePresenter?.displayPlaceholderOrTableView()
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
        
        // Assign Table View Helper
        appointmentsTableViewHelper = .init(appointmentsTableView,
                                            homePresenter!,
                                            self)
        
        // Assign placeholder view
        placeholderView = .init(containerView,
                                randevuOlusturButton)
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
        
        // Create navigation title's attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        
        // Create navigation bar's appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = ThemeManager.color.navigationBackground
        appearance.titleTextAttributes = attributes
        
        // Set navigation bar appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        // Set navigation bar title
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
        view.backgroundColor = ThemeManager.color.navigationBackground
        
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
