//
//  ViewController.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 28.06.2022.
//

import UIKit

class LoginView: UIViewController, LoginContract.loginView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var requirementLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var girisYapButton: UIButton!
    
    var loginPresenter: LoginContract.loginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call setupUI method to prepare UI components
        setupUI()
    }

    @IBAction func didPressGirisYapButton(_ sender: Any) {
        if let email = emailTextField.text, email != "" {
            // Get device identifier and assign it as deviceUDID
            if let deviceUDID = UIDevice.current.identifierForVendor?.uuidString {
                loginPresenter.didUserPressGirisYapButton(with: email, and: deviceUDID)
            }
        }
    }
}

// MARK: - SELF RELATED METHODS
extension LoginView {
    
    /**
     SetupUI method does setup UI as its name implies.
     It prepares UI components to conform to zeplin guideline
     of the
     
     -returns: None
     */
    // MARK: - setupUI
    private func setupUI() {
        // Set navigation bar
        setNavigationBar()
        
        // Set background colors of views up
        setViews()
        
        // Set welcome label as attributed text
        setWelcomeLabel()
        
        // Set requirement label
        setRequirementLabel()
        
        // Set e-mail text field
        setEmailTextField()
        
        // Set giriş yap button's forground
        setGirisYapButton()
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        // Set navigation title as attributed string
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Giriş Yapın"
    }
    
    // MARK: - setViews
    private func setViews() {
        // Set super view's background color
        view.backgroundColor = ThemeManager.color.background
        
        // Set super view's background color
        containerView.backgroundColor = ThemeManager.color.background
        
        /*
         Create and assign tap gesture recognizer to container view for
         hiding keyboard functionality
         */
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        containerView.addGestureRecognizer(gestureRecognizer)
    }
    
    /**
     SetWelcomeLabel method sets welcome label as attributed string by
     declaring two different strings as NSAttributedString and
     combines them in the end. You can change the attributes of the
     string by creating [NSAttributedString.Key: Any] dictionary and
     assigning it to the specific string by using NSAttributedString.
     
     -Note: Don't forget to declare first part of the string as mutable
     attributed string, otherwise you cannot append them together.
     
     -returns: None
     */
    // MARK: - setWelcomeLabel
    private func setWelcomeLabel() {
        // Set first part of the attributed string
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 26, weight: .bold), .foregroundColor: ThemeManager.color.title!]
        let firstPart = NSMutableAttributedString(string: "Charger'a ", attributes: firstAttributes)
        
        // Set second part of the attributed string
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 26, weight: .regular), .foregroundColor: ThemeManager.color.title!]
        let secondPart = NSAttributedString(string: "hoş geldiniz.", attributes: secondAttributes)
        
        firstPart.append(secondPart)
        
        // Assign attributed string to welcome label
        welcomeLabel.attributedText = firstPart
        welcomeLabel.textAlignment = .center
    }
    
    // MARK: - setRequirementLabel
    private func setRequirementLabel() {
        requirementLabel.text = "Charger'ı kullanmak için giriş " +
                                "yapmanız\n gerekiyor."
        requirementLabel.textColor = ThemeManager.color.subtitle
        requirementLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        requirementLabel.numberOfLines = 0
        requirementLabel.textAlignment = .center
    }
    
    // MARK: - setEmailTextField
    private func setEmailTextField() {
        // Set text field style
        emailTextField.backgroundColor = ThemeManager.color.background
        emailTextField.borderStyle = .none
        
        // Set placeholder as attributed
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ThemeManager.color.subtitle!,
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        let attributedPlaceholder = NSAttributedString(string: "E-POSTA ADRESİNİZ",
                                                       attributes: attributes)
        emailTextField.attributedPlaceholder = attributedPlaceholder
        
        // Set text style
        emailTextField.textColor = ThemeManager.color.subtitle
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // Set keyboard settings
        emailTextField.textContentType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .sentences
        
        // Set delegate of email text field to self
        emailTextField.delegate = self
    }
    
    // MARK: - setGirisYapButton
    private func setGirisYapButton() {
        girisYapButton.titleLabel?.isHidden = true
        girisYapButton.configuration = .plain()
        girisYapButton.setImage(ThemeManager.image.buttonGirisYap, for: .normal)
    }
}

// MARK: - showAlert
// Show alert button on top of login view
extension LoginView {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TEXT FIELD DELEGATE
// Make keyboard disappear from screen
extension LoginView: UITextFieldDelegate {
    
    // By using text field delegate method
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return true
    }
    
    // By tapping blank space on the view
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
