//
//  ProvincesTableViewHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import UIKit

class ProvincesTableViewHelper: NSObject {
    
    // MARK: Properties
    private var provinces =  [String]()
    
    private var searchText: String?
    
    private weak var provincesTableView: UITableView?
    
    var provinceSearchPresenter: ProvinceSearchContract.provinceSearchPresenter!
    
    var provinceSearchView: ProvinceSearchView?
    
    // Initializer for provinces table view helper
    init(_ provincesTableView: UITableView,
         _ provinceSearchPresenter: ProvinceSearchContract.provinceSearchPresenter,
         _ provinceSearchView: ProvinceSearchView) {
        
        super.init()
        
        // Assign table view and presenter came from view layer
        self.provincesTableView = provincesTableView
        self.provinceSearchPresenter = provinceSearchPresenter
        self.provinceSearchView = provinceSearchView
        
        // Assign self as delegate and datasource of table view
        provincesTableView.delegate = self
        provincesTableView.dataSource = self
    }
    
    
}

// Self related methods
extension ProvincesTableViewHelper {
    
    // MARK: - set provinces
    func set(provinces: [String], with searchText: String) {
        self.provinces = provinces
        self.searchText = searchText
        
        // Animate reloding table view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.provincesTableView?.reloadData()
        }
        
    }
    
}

// MARK: - TABLE VIEW DELEGATE
extension ProvincesTableViewHelper: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Send selected province to presenter in string format
        provinceSearchPresenter.didSelectProvince(provinces[indexPath.row],
                                                  provinceSearchView!)
    }
    
    // Disable table view's highlighting feature when the row is selected
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
}

// MARK: - TABLE VIEW DATA SOURCE
extension ProvincesTableViewHelper: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create provinces table view cell
        let provincesTableViewCell = createProvincesTableViewCell(indexPath)
        
        return provincesTableViewCell
    }
    
}

// Create provinces table view cell
extension ProvincesTableViewHelper {
    
    // MARK: - createProvincesTableViewCell
    private func createProvincesTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let provincesTableViewCell = UITableViewCell()
        
        // Assign cell background color
        provincesTableViewCell.backgroundColor = ThemeManager.color.background
        
        // Create province label
        let provinceLabel = createProvinceLabel(indexPath)
        
        // Add province label to provinces table view cell
        provincesTableViewCell.addSubview(provinceLabel)
        
        // Take content view of table view cell for
        // assigning constraints to province label
        let contentView = provincesTableViewCell.contentView
        
        // Assign constraints to label
        NSLayoutConstraint.activate([
            provinceLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 8
            ),
            provinceLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16
            ),
            provinceLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16
            ),
            provinceLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -8
            ),
            provinceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return provincesTableViewCell
    }
    
    // MARK: - createProvinceLabel
    private func createProvinceLabel(_ indexPath: IndexPath) -> UILabel {
        let provinceLabel = UILabel()
        provinceLabel.translatesAutoresizingMaskIntoConstraints = false
        provinceLabel.textColor = ThemeManager.color.title
        provinceLabel.font = .systemFont(ofSize: 16, weight: .regular)
        provinceLabel.text = provinces[indexPath.row]
    
        return provinceLabel
    }
    
}
