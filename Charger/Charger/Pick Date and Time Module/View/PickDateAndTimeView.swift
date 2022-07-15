//
//  PickDateAndTimeView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 15.07.2022.
//

import UIKit

class PickDateAndTimeView: UIViewController, PickDateAndTimeContract.pickDateAndTimeView {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    // Date stack stack view
    @IBOutlet weak var appointmentDateLabel: UILabel!
    @IBOutlet weak var appointmentDateValueTextField: UITextField!
    
    // First socket stack view
    @IBOutlet weak var firstSocketStackView: UIStackView!
    @IBOutlet weak var firstSocketNumberLabel: UILabel!
    @IBOutlet weak var firstChargeAndSocketTypeLabel: UILabel!
    @IBOutlet weak var firstSocketTableView: UITableView!
    
    // Second socket stack view
    @IBOutlet weak var secondSocketStackView: UIStackView!
    @IBOutlet weak var secondSocketNumberLabel: UILabel!
    @IBOutlet weak var secondChargeAndSocketTypeLabel: UILabel!
    @IBOutlet weak var secondSocketTableView: UITableView!
    
    // Third socket stack view
    @IBOutlet weak var thirdSocketStackView: UIStackView!
    @IBOutlet weak var thirdSocketNumberLabel: UILabel!
    @IBOutlet weak var thirdChargeAndSocketTypeLabel: UILabel!
    @IBOutlet weak var thirdSocketTableView: UITableView!
    
    // Devam et button
    @IBOutlet weak var devamEtButton: UIButton!
    
    // MARK: - Properties
    var stationName: String?
    
    var sockets = [SocketInfo]()
    
    var socketCount: Int {
        sockets.count
    }
    
    var pickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call viewDidLoad method in presenter
        pickDateAndTimePresenter?.viewDidLoad()
        
        // Set up ui components
        setupUI()
        
    }
    
    // MARK: - didPressDevamEtButton
    @IBAction func didPressDevamEtButton(_ sender: Any) {
        
        // Call did press devam et button in presenter
        pickDateAndTimePresenter?.didPressDevamEtButton(self)
        
    }
    
}

// Setting up ui components
extension PickDateAndTimeView {
    
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
        
        // Set appointment date label
        setAppointmentDateLabel()
        
        // Set devam et button
        setDevamEtButton()
        
    }
    
    // MARK: - setBackgroundViews
    private func setBackgroundViews() {
        
        // Set super view's background color
        superView.backgroundColor = ThemeManager.color.navigationBackground
        
        // Set container view's background color
        containerView.backgroundColor = ThemeManager.color.background
        
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        
        // Set navigation back bar button
        setNavigationBackBarButton()
        
        // Set navigation title
        setNavigationTitle()
        
    }
    
    // MARK: - setNavigationBackBarButton
    private func setNavigationBackBarButton() {
        
        // Set navigation back bar button
        navigationController?.navigationBar.tintColor = ThemeManager.color.title
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        
    }
    
    // MARK: - setNavigationTitle
    private func setNavigationTitle() {
        
        // Create navigation title's in uiview
        setNavigationTitleView()
        
    }
    
    // MARK: - setNavigationTitleView
    private func setNavigationTitleView() {
        
        // Create navigation view
        let navigationView = UIView()
        
        // Create navigation title label
        let titleLabel = UILabel()
        
        // Create navigation title's attributes
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        // Create navigation title attributed string
        let titleAttributedText = NSAttributedString(string: "Tarih ve Saat Seçin",
                                                     attributes: titleAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        
        // Create navigation subtitle label
        let subtitleLabel = UILabel()
        
        // Create navigation subtitle's attributes
        let subTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: ThemeManager.color.subtitle!
        ]
        // Create navigation title attributed string
        let subtitleAttributedText = NSAttributedString(string: stationName!,
                                                        attributes: subTitleAttributes)
        subtitleLabel.attributedText = subtitleAttributedText
        subtitleLabel.sizeToFit()
        subtitleLabel.textAlignment = .center
        
        // Put title and subtitle label into array for
        // putting in stack view
        let arrangedSubViews: [UIView] = [titleLabel, subtitleLabel]
        
        // Crete stack view with title and subtitle labels
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = .vertical
        
        // Assign it to navigation view
        navigationView.addSubview(stackView)
        stackView.center = navigationView.center
        
        // Assign navigation view as subview of navigation item
        navigationItem.titleView = navigationView
        navigationView.sizeToFit()
        
    }
    
    // MARK: - setAppointmentDateLabel
    private func setAppointmentDateLabel() {
        
        // Create label attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        
        // Create navigation title attributed string
        appointmentDateLabel.attributedText = NSAttributedString(string: "Randevu Tarihi",
                                                                 attributes: attributes)
        
    }
    
    /**
     Awake table views method looks at socket count
     and displays socket stack views according to that.
     
     returns: None
     */
    // MARK: - awakeTableViews
    private func awakeTableViews() {
        
        switch socketCount {
        case 1:
            
            // Set first label stack view
            setFirstLabelStackView()
            
            // Initialize first socket table view helper
            
            // Hide rest of the stack views
            secondSocketStackView.isHidden = true
            thirdSocketStackView.isHidden = true
            
        case 2:
            
            // Set first and second label stack view
            setFirstLabelStackView()
            setSecondLabelStackView()
            
            // Initialize first and second socket table view helpers
            
            // Hide rest of the stack views
            thirdSocketStackView.isHidden = true
            
        case 3:
            
            // Set first, second and third label stack view
            setFirstLabelStackView()
            setSecondLabelStackView()
            setThirdLabelStackView()
            
            // Initialize first, second and third socket table view helper
            
        default:
            
            // Hide all of the stack views
            firstSocketStackView.isHidden = true
            secondSocketStackView.isHidden = true
            thirdSocketStackView.isHidden = true
            
        }
        
    }
    
    // MARK: - setFirstLabelStackView
    private func setFirstLabelStackView() {
        
        // Get the properties of label stack view
        let socketNumber = sockets[0].socketNumber
        let chargeType = sockets[0].chargeType
        let socketType = sockets[0].socketType
        
        // Set socket number label
        firstSocketNumberLabel.font = .systemFont(ofSize: 22, weight: .bold)
        firstSocketNumberLabel.text = "Soket \(socketNumber ?? 1)"
        firstSocketNumberLabel.textAlignment = .center
        firstSocketNumberLabel.textColor = ThemeManager.color.title!
        
        // Set charge and socket type label
        firstChargeAndSocketTypeLabel.font = .systemFont(ofSize: 16, weight: .regular)
        firstChargeAndSocketTypeLabel.text = (chargeType ?? "") + " • " + (socketType ?? "")
        firstChargeAndSocketTypeLabel.textAlignment = .center
        firstChargeAndSocketTypeLabel.textColor = ThemeManager.color.subtitle!
        
    }
    
    // MARK: - setSecondLabelStackView
    private func setSecondLabelStackView() {
        
        // Get the properties of label stack view
        let socketNumber = sockets[1].socketNumber
        let chargeType = sockets[1].chargeType
        let socketType = sockets[1].socketType
        
        // Set socket number label
        secondSocketNumberLabel.font = .systemFont(ofSize: 22, weight: .bold)
        secondSocketNumberLabel.text = "Soket \(socketNumber ?? 2)"
        secondSocketNumberLabel.textAlignment = .center
        secondSocketNumberLabel.textColor = ThemeManager.color.title!
        
        // Set charge and socket type label
        secondChargeAndSocketTypeLabel.font = .systemFont(ofSize: 16, weight: .regular)
        secondChargeAndSocketTypeLabel.text = (chargeType ?? "") + " • " + (socketType ?? "")
        secondChargeAndSocketTypeLabel.textAlignment = .center
        secondChargeAndSocketTypeLabel.textColor = ThemeManager.color.subtitle!
        
    }
    
    // MARK: - setThirdLabelStackView
    private func setThirdLabelStackView() {
        
        // Get the properties of label stack view
        let socketNumber = sockets[2].socketNumber
        let chargeType = sockets[2].chargeType
        let socketType = sockets[2].socketType
        
        // Set socket number label
        thirdSocketNumberLabel.font = .systemFont(ofSize: 22, weight: .bold)
        thirdSocketNumberLabel.text = "Soket \(socketNumber ?? 3)"
        thirdSocketNumberLabel.textAlignment = .center
        thirdSocketNumberLabel.textColor = ThemeManager.color.title!
        
        // Set charge and socket type label
        thirdChargeAndSocketTypeLabel.font = .systemFont(ofSize: 16, weight: .regular)
        thirdChargeAndSocketTypeLabel.text = (chargeType ?? "") + " • " + (socketType ?? "")
        thirdChargeAndSocketTypeLabel.textAlignment = .center
        thirdChargeAndSocketTypeLabel.textColor = ThemeManager.color.subtitle!
        
    }
    
    // MARK: - setDevamEtButton
    private func setDevamEtButton() {
        
        // Set devam et button image
        
    }
    
}

// Self related
extension PickDateAndTimeView {
    
    // MARK: setSockets
    func set(sockets: [SocketInfo]) {
        // Initialize fetched sockets came from
        // presenter to the self sockets array
        self.sockets = sockets
        
        // Awake table views depending on
        // socket count
        awakeTableViews()
    }
    
}
