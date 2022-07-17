//
//  AppointmentDetailsTableViewHeader.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class AppointmentDetailsTableViewHeader: UITableViewHeaderFooterView {

    // Set header title
    let headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = .systemFont(ofSize: 18, weight: .bold)
        headerTitle.textColor = ThemeManager.color.subtitle
        return headerTitle
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        assignConstraintsToHeaderTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// Assigning constraints to  header title label
extension AppointmentDetailsTableViewHeader {
    
    private func assignConstraintsToHeaderTitle() {
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        // Add header title label as subview of content view
        contentView.addSubview(headerTitle)
        
        // Assign constraints to header title
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8
            ),
            headerTitle.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8
            ),
            headerTitle.heightAnchor.constraint(
                equalToConstant: 40
            ),
            headerTitle.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            )
        ])
    }
    
}
