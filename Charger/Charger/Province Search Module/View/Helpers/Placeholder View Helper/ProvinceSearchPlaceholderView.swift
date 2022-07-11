//
//  ProvinceSearchPlaceholderView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 11.07.2022.
//

import UIKit

class ProvinceSearchPlaceholderView: NSObject {
    
    // View the placeholder will be presented on
    private var targetView: UIView?
    
    // Provinces table view in province search view
    // to set constraints to
    private weak var provincesTableView: UITableView?
    
    init(_ targetView: UIView, _ provincesTableView: UITableView) {
        super.init()
        
        // Assign target view and provinces table view
        self.targetView = targetView
        self.provincesTableView = provincesTableView
        
        // Set ui component's constarints
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
    
    // MARK: - title label
    // Create title label
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Aramanız ile eşleşen bir sonuç bulunamadı."
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
        messageLabel.text = "Lütfen yeni bir arama yapın."
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 18, weight: .regular)
        messageLabel.textColor = ThemeManager.color.subtitle
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholder.addSubview(messageLabel)
        return messageLabel
    }()
    
    // Notifies province search view about whether
    // placeholder view is hidden
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
extension ProvinceSearchPlaceholderView {
    
    // MARK: - setConstraints
    private func setConstraints() {
        
        // Unwrap provinces table view
        guard let provincesTableView = provincesTableView else { return }
        
        // MARK: - Set placeholder view constraint
        placeholder.frame = provincesTableView.frame
        
        // MARK: - Set title label constraint
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(
                equalTo: placeholder.centerYAnchor, constant: -50
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: placeholder.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: placeholder.trailingAnchor,
                constant: -16
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
