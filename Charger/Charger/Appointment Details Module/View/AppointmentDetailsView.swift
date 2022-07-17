//
//  AppointmentDetailsView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class AppointmentDetailsView: UIViewController {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var appointmentDetailsTableView: UITableView!
    @IBOutlet weak var randevuyuOnaylaButton: UIButton!
    
    // MARK: - Properties
    var stationName: String?
    
    var appointmentDetailsPresenter: AppointmentDetailsContract.appointmentDetailsPresenter?

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up ui components
        setupUI()

        // Call viewDidLoad in presenter
        appointmentDetailsPresenter?.viewDidLoad()
    }

    @IBAction func didPressRandevuyuOnaylaButton(_ sender: Any) {
        // Call didPressRandevuyuOnaylaButton in presenter
        appointmentDetailsPresenter?.didPressRandevuyuOnaylaButton(self)
    }
}

// Setting up ui components
extension AppointmentDetailsView {
    
    /**
     SetupUI method does setup UI as its name implies.
     It prepares UI components to conform to zeplin guideline
     of the project.
     
     -returns: None
     */
    // MARK: - setupUI
    private func setupUI() {
        
        // Set background views
        setBackgroundViews()
        
        // Set navigation bar
        setNavigationBar()
        
        // Set randevuyu onayla button
        setRandevuyuOnaylaButton()
        
    }
    
    // MARK: - setBackgroundViews
    private func setBackgroundViews() {
        
        // Set super view's background color
        superView.backgroundColor = ThemeManager.color.navigationBackground
        
        // Set container view's background color
        containerView.backgroundColor = ThemeManager.color.background
        
        // Set table views background colors
        appointmentDetailsTableView.backgroundColor = ThemeManager.color.background
        
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        
        // Set navigation back bar button
        setNavigationBackBarButton()
        
        // Set navigation title stack view
        setNavigationTitleStackView()
        
    }
    
    // MARK: - setNavigationBackBarButton
    private func setNavigationBackBarButton() {
        
        // Set navigation back bar button
        navigationController?.navigationBar.tintColor = ThemeManager.color.title
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        
    }
    
    // MARK: - setNavigationTitleStackView
    private func setNavigationTitleStackView() {
        
        // Create navigation title label
        let titleLabel = UILabel()
        
        // Create navigation title's attributes
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        // Create navigation title attributed string
        let titleAttributedText = NSAttributedString(string: "Randevu Detayı",
                                                     attributes: titleAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        
        // Create navigation subtitle label
        let subtitleLabel = UILabel()
        
        // Create navigation subtitle's attributes
        let subTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: ThemeManager.color.subtitle!
        ]
        // Create navigation title attributed string
        let subtitleAttributedText = NSAttributedString(string: stationName ?? "",
                                                        attributes: subTitleAttributes)
        subtitleLabel.attributedText = subtitleAttributedText
        subtitleLabel.sizeToFit()
        subtitleLabel.textAlignment = .center
        
        // Put title and subtitle label into array for
        // putting in stack view
        let arrangedSubViews: [UIView] = [titleLabel, subtitleLabel]
        
        // Crete stack view with title and subtitle labels
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        // Unwrap navigation bar
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        // Add stack view to navigation bar and add constraints
        navigationBar.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(
                equalTo: navigationBar.centerXAnchor
            ),
            stackView.centerYAnchor.constraint(
                equalTo: navigationBar.centerYAnchor
            )
        ])
        
        // Assign navigation view as subview of navigation item
        navigationItem.titleView = stackView
        
    }
    
    // MARK: - setRandevuyuOnaylaButton
    private func setRandevuyuOnaylaButton() {
        randevuyuOnaylaButton.titleLabel?.isHidden = true
        randevuyuOnaylaButton.configuration = .plain()
        randevuyuOnaylaButton.setImage(ThemeManager.image.buttonRandevuyuOnayla,
                                       for: .normal)
    }
    
}

// Self related methods
extension AppointmentDetailsView: AppointmentDetailsContract.appointmentDetailsView  {
    
    // MARK: - updateAppointmentDetailsTableView
    func updateAppointmentDetailsTableView(with appointmentDetails: [AppointmentDetail]) {
        
        
        
    }
    
    // MARK: - displayDropDownLabel
    func displayDropDownLabel() {
        
        
        
    }
    
    // MARK: - hideDropDownLabel
    func hideDropDownLabel() {
        
        
        
    }
    
}
