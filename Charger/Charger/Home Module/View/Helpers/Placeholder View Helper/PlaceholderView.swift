//
//  PlaceholderView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 8.07.2022.
//

import UIKit

class PlaceholderView: NSObject {
    
    // View the placeholder will be presented on
    private var targetView: UIView?
    
    // Randevu oluştur button in home view to set constraint to
    private var randevuOlusturButton: UIButton?
    
    // Take the target view when initializing the alert view
    init(_ targetView: UIView,
         _ randevuOlusturButton: UIButton) {
        super.init()
        
        self.targetView = targetView
        self.randevuOlusturButton = randevuOlusturButton
        
        // Set ui components constraints
        setConstraints()
    }
    
    // MARK: - placeholder
    // Create placeholder view
    private lazy var placeholder: UIView = {
        let placeholder = UIView()
        placeholder.backgroundColor = ThemeManager.color.background
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        targetView?.addSubview(placeholder)
        return placeholder
    }()
    
    // MARK: - logo
    // Create logo image view
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.image = ThemeManager.image.logoHomepage
        logo.translatesAutoresizingMaskIntoConstraints = false
        placeholder.addSubview(logo)
        return logo
    }()
    
    // MARK: - title label
    // Create title label
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Henüz bir randevu oluşturmadınız."
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = ThemeManager.color.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholder.addSubview(titleLabel)
        return titleLabel
    }()
    
    // MARK: - message label
    // Create message label
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "Oluşturulan randevular burada listelenir."
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 18, weight: .regular)
        messageLabel.textColor = ThemeManager.color.subtitle
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholder.addSubview(messageLabel)
        return messageLabel
    }()
    
    // Notifies home view about whether placeholder view is hidden
    var isHidden: Bool {
        get {
            placeholder.isHidden
        }
        
        set {
            placeholder.isHidden = newValue
        }
    }
    
}

// Configuring constraints of ui components method
extension PlaceholderView {
    
    private func setConstraints() {
        
        // Unwrap target view
        guard let targetView = targetView else { return }
        
        // Unwrap randevu oluştur button
        guard let randevuOlusturButton = randevuOlusturButton else { return }
        
        // MARK: - Set placeholder view constraint
        NSLayoutConstraint.activate([
            
            placeholder.topAnchor.constraint(
                equalTo: targetView.topAnchor
            ),
            placeholder.leadingAnchor.constraint(
                equalTo: targetView.leadingAnchor
            ),
            placeholder.trailingAnchor.constraint(
                equalTo: targetView.trailingAnchor
            ),
            placeholder.bottomAnchor.constraint(
                equalTo: randevuOlusturButton.topAnchor,
                constant: -40
            )
        ])
        
        // MARK: - Set logo image view constraint
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(
                equalTo: placeholder.centerXAnchor
            ),
            logo.topAnchor.constraint(
                equalTo: placeholder.topAnchor,
                constant: 50
            ),
            logo.widthAnchor.constraint(
                equalTo: placeholder.widthAnchor,
                multiplier: 0.4
            ),
            logo.heightAnchor.constraint(
                equalTo: logo.widthAnchor
            )
        ])
        
        // MARK: - Set title label constraint
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: logo.bottomAnchor,
                constant: 50
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: placeholder.centerXAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: placeholder.leadingAnchor,
                constant: 32
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: placeholder.trailingAnchor,
                constant: -32
            )
        ])
        
        // MARK: -  Set message label constraint
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),
            messageLabel.centerXAnchor.constraint(
                equalTo: placeholder.centerXAnchor
            ),
            messageLabel.leadingAnchor.constraint(
                equalTo: placeholder.leadingAnchor,
                constant: 16
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: placeholder.trailingAnchor,
                constant: -16
            )
        ])
        
    }
    
}
