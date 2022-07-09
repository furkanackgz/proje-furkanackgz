//
//  ProfileView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 9.07.2022.
//

import UIKit

class ProfileView: UIViewController {

    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileLogo: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var emailKeyLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!
    @IBOutlet weak var deviceIDKeyLabel: UILabel!
    @IBOutlet weak var deviceIDValueLabel: UILabel!
    @IBOutlet weak var cikisYapButton: UIButton!
    
    // MARK: - Properties
    var profilePresenter: ProfileContract.profilePresenter?
    
    var email: String? {
        didSet {
            setEmailValueLabel()
        }
    }
    
    var deviceID: String? {
        didSet {
            setDeviceIDValueLabel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set ui components
        setupUI()
        
        // Call presenter viewDidLoad method
        profilePresenter?.viewDidLoad()
        
    }
    
    // MARK: - didPressCikisYapButton
    @IBAction func didPressCikisYapButton(_ sender: Any) {
        profilePresenter?.didPressCikisYapButton(self)
    }
    
}

// Setting up ui components
extension ProfileView {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set navigation bar
        setNavigationBar()
        
        // Set background and info views
        setViews()
        
        // Set profile logo
        setProfileLogo()
        
        // Set Email and DeviceID labels
        setEmailAndDeviceIDKeyLabels()
        
        // Set Çıkış Yap button
        setCikisYapButton()
        
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        
        // Set navigation background color
        superView.backgroundColor = ThemeManager.color.navigationBackground
        
        // Set navigation bar back button
        navigationController?.navigationBar.tintColor = ThemeManager.color.title
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        
        // Create navigation title's attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        
        // Set navigation bar title
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Profil"
        
    }
    
    // MARK: - setViews
    private func setViews() {
        
        // Set background color
        containerView.backgroundColor = ThemeManager.color.background
        
        // Set info view background color and layer radious
        infoView.backgroundColor = ThemeManager.color.accent
        infoView.layer.cornerRadius = 8
        
    }
    
    // MARK: - setProfileLogo
    private func setProfileLogo() {
        
        profileLogo.contentMode = .scaleAspectFit
        profileLogo.image = ThemeManager.image.logoProfilePage
        
    }
    
    // MARK: - setEmailAndDeviceIDKeyLabels
    private func setEmailAndDeviceIDKeyLabels() {
        
        // Set email key label
        setEmailKeyLabel()
        
        // Set deviceID key label
        setDeviceIDKeyLabel()
    }
    
    // MARK: - setEmailKeyLabel
    private func setEmailKeyLabel() {
        
        // Set email key label
        emailKeyLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailKeyLabel.textColor = ThemeManager.color.subtitle
        emailKeyLabel.text = "E-posta:"
        
    }
    
    // MARK: - setDeviceIDKeyLabel
    private func setDeviceIDKeyLabel() {
        
        // Set deviceID key label
        deviceIDKeyLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        deviceIDKeyLabel.textColor = ThemeManager.color.subtitle
        deviceIDKeyLabel.text = "Cihaz ID:"

    }
    
    // MARK: - setEmailValueLabel
    private func setEmailValueLabel() {
        
        // Set email value label
        emailValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        emailValueLabel.textColor = ThemeManager.color.title
        emailValueLabel.text = email ?? ""
        
    }
    
    // MARK: - setDeviceIDValueLabel
    private func setDeviceIDValueLabel() {
        
        // Set deviceID value label
        deviceIDValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        deviceIDValueLabel.textColor = ThemeManager.color.title
        deviceIDValueLabel.text = deviceID ?? ""
        
    }
    
    // MARK: - setCikisYapButton
    private func setCikisYapButton() {
        
        cikisYapButton.titleLabel?.isHidden = true
        cikisYapButton.configuration = .plain()
        cikisYapButton.setImage(ThemeManager.image.buttonCikisYap, for: .normal)
        
    }
    
}

// Self related methods
extension ProfileView: ProfileContract.profileView {
    
    // MARK: - setProfileViewData
    func setProfileViewData(with email: String, and deviceID: String) {
        
        self.email = email
        self.deviceID = deviceID
        
    }
    
    // MARK: - showAlert
    func showAlert(with title: String, and message: String) {
        
        // Create alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create Ok alert action
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        
        // Present alert on profile screen
        present(alert, animated: true)
        
    }
    
}
