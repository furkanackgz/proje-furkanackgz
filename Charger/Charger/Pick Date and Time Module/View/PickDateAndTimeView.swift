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
    
    // After station name set, call set navigation
    // bar again because it may take longer to
    // fetch from server than expected.
    var stationName: String? {
        didSet{
            setNavigationBar()
        }
    }
    
    var sockets = [SocketInfo]()
    
    var socketCount: Int {
        sockets.count
    }
    
    var pickDateAndTimePresenter: PickDateAndTimeContract.pickDateAndTimePresenter?
    
    // Table view helpers
    var firstSocketTableViewHelper: SocketTableViewHelper?
    var secondSocketTableViewHelper: SocketTableViewHelper?
    var thirdSocketTableViewHelper: SocketTableViewHelper?
    
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
        
        // Set table views background colors
        firstSocketTableView.backgroundColor = ThemeManager.color.background
        secondSocketTableView.backgroundColor = ThemeManager.color.background
        thirdSocketTableView.backgroundColor = ThemeManager.color.background
        
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
        let titleAttributedText = NSAttributedString(string: "Tarih ve Saat Seçin",
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
    
    // MARK: - setAppointmentDateLabel
    private func setAppointmentDateLabel() {
        
        // Create label attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
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
            firstSocketTableViewHelper = .init(sockets[0],
                                               firstSocketTableView,
                                               pickDateAndTimePresenter!)
            
            // Get first socket's time slots
            let firstSocketTimeSlots = sockets[0].day?.timeSlots
            
            // Set first socket's time slots
            firstSocketTableViewHelper?.set(firstSocketTimeSlots!)
            
            // Hide rest of the stack views
            secondSocketStackView.isHidden = true
            thirdSocketStackView.isHidden = true
            
        case 2:
            
            // Set first and second label stack view
            setFirstLabelStackView()
            setSecondLabelStackView()
            
            // Initialize first socket table view helper
            firstSocketTableViewHelper = .init(sockets[0],
                                               firstSocketTableView,
                                               pickDateAndTimePresenter!)
            
            // Get first socket's time slots
            let firstSocketTimeSlots = sockets[0].day?.timeSlots
            
            // Set first socket's time slots
            firstSocketTableViewHelper?.set(firstSocketTimeSlots!)
            
            // Initialize second socket table view helper
            secondSocketTableViewHelper = .init(sockets[1],
                                                secondSocketTableView,
                                                pickDateAndTimePresenter!)
            
            // Get second socket's time slots
            let secondSocketTimeSlots = sockets[1].day?.timeSlots
            
            // Set second socket's time slots
            secondSocketTableViewHelper?.set(secondSocketTimeSlots!)
            
            // Hide rest of the stack views
            thirdSocketStackView.isHidden = true
            
        case 3:
            
            // Set first, second and third label stack view
            setFirstLabelStackView()
            setSecondLabelStackView()
            setThirdLabelStackView()
            
            // Initialize first socket table view helper
            firstSocketTableViewHelper = .init(sockets[0],
                                               firstSocketTableView,
                                               pickDateAndTimePresenter!)
            
            // Get first socket's time slots
            let firstSocketTimeSlots = sockets[0].day?.timeSlots
            
            // Set first socket's time slots
            firstSocketTableViewHelper?.set(firstSocketTimeSlots!)
            
            // Initialize second socket table view helper
            secondSocketTableViewHelper = .init(sockets[1],
                                                secondSocketTableView,
                                                pickDateAndTimePresenter!)
            
            // Get second socket's time slots
            let secondSocketTimeSlots = sockets[1].day?.timeSlots
            
            // Set second socket's time slots
            secondSocketTableViewHelper?.set(secondSocketTimeSlots!)
            
            // Initialize third socket table view helper
            thirdSocketTableViewHelper = .init(sockets[2],
                                               thirdSocketTableView,
                                               pickDateAndTimePresenter!)
            
            // Get third socket's time slots
            let thirdSocketTimeSlots = sockets[2].day?.timeSlots
            
            // Set third socket's time slots
            thirdSocketTableViewHelper?.set(thirdSocketTimeSlots!)
            
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
        firstSocketNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        firstSocketNumberLabel.text = "Soket \(socketNumber ?? 1)"
        firstSocketNumberLabel.textAlignment = .center
        firstSocketNumberLabel.textColor = ThemeManager.color.title!
        
        // Set charge and socket type label
        firstChargeAndSocketTypeLabel.font = .systemFont(ofSize: 12, weight: .regular)
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
        secondSocketNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        secondSocketNumberLabel.text = "Soket \(socketNumber ?? 2)"
        secondSocketNumberLabel.textAlignment = .center
        secondSocketNumberLabel.textColor = ThemeManager.color.title!
        
        // Set charge and socket type label
        secondChargeAndSocketTypeLabel.font = .systemFont(ofSize: 12, weight: .regular)
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
        thirdSocketNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        thirdSocketNumberLabel.text = "Soket \(socketNumber ?? 3)"
        thirdSocketNumberLabel.textAlignment = .center
        thirdSocketNumberLabel.textColor = ThemeManager.color.title!
        
        // Set charge and socket type label
        thirdChargeAndSocketTypeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        thirdChargeAndSocketTypeLabel.text = (chargeType ?? "") + " • " + (socketType ?? "")
        thirdChargeAndSocketTypeLabel.textAlignment = .center
        thirdChargeAndSocketTypeLabel.textColor = ThemeManager.color.subtitle!
        
    }
    
    // MARK: - setDevamEtButton
    private func setDevamEtButton() {
        
        // Set devam et button image
        devamEtButton.titleLabel?.isHidden = true
        devamEtButton.configuration = .plain()
        devamEtButton.setImage(ThemeManager.image.buttonTarihiVeSaatiOnayla,
                               for: .normal)
        
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
