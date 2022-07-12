//
//  ProvinceSearchView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import UIKit

class ProvinceSearchView: UIViewController {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var provincesTableView: UITableView!
    
    // MARK: - Properties
    var provinceSearchPresenter: ProvinceSearchContract.provinceSearchPresenter?
    
    var isPlaceholderViewHidden: Bool?
    
    private var provinces = [String]()
    
    private var provincesTableViewHelper: ProvincesTableViewHelper!
    
    private var provinceSearchPlaceholderView: ProvinceSearchPlaceholderView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set ui components
        setupUI()
        
        // Call viewDidLoad in province search presenter
        provinceSearchPresenter?.viewDidLoad()
    }

}

// Setting up ui components
extension ProvinceSearchView {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set navigation bar
        setNavigationBar()
        
        // Set search bar
        setSearchBar()
        
        // Set table view
        setProvincesTableView()
        
        // Assign placeholder view
        provinceSearchPlaceholderView = .init(containerView,
                                               provincesTableView)
        
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
        title = "Şehir Seçin"
        
    }
    
    // MARK: - setSearchBar
    private func setSearchBar() {
        
        // Set self as search bar delegate
        searchBar.delegate = self
        
        // Set search bar view background color
        searchBar.barTintColor = ThemeManager.color.background
        
        // Set search bar text field background color
        searchBar.searchTextField.backgroundColor = ThemeManager.color.searchBarBackground
        
        // Set search bar text field layer
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.borderColor = ThemeManager.color.searchBarBorder?.cgColor
        
        // Set search bar magnifying symbol color
        searchBar.searchTextField.leftView?.tintColor = ThemeManager.color.title
        
        // Set search bar text field text color
        searchBar.searchTextField.textColor = ThemeManager.color.title
        
        // Set search bar placeholder
        searchBar.placeholder = "Şehir Ara"
        
    }
    
    // MARK: - setProvincesTableView
    private func setProvincesTableView() {
        
        // Set provinces table view background color
        provincesTableView.backgroundColor = ThemeManager.color.background
        
        // Initialize provinces table view helper
        provincesTableViewHelper = .init(provincesTableView,
                                         provinceSearchPresenter!,
                                         self)
        
    }
    
}

// Search bar related methods
extension ProvinceSearchView: UISearchBarDelegate {
    
    // MARK: - searchBarTextDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Call didEditSearchText method in presenter for notifying
        // that search text was changed by the user
        provinceSearchPresenter?.didEditSearchText(searchText)
    }
    
}

// Self related methods
extension ProvinceSearchView: ProvinceSearchContract.provinceSearchView {
    
    // MARK: - updateProvincesTableView
    func updateProvincesTableView(with provinces: [String], and searchText: String) {
        provincesTableViewHelper.set(provinces: provinces, with: searchText)
    }
    
    // MARK: - displayPlaceholderView
    func displayPlaceholderView() {
        
        // Animate displaying placeholder view for
        // better user experience
        UIView.animate(withDuration: 1, delay: 1) { [weak self] in
            // Expose placeholder view
            self?.provinceSearchPlaceholderView?.isHidden = false
            
            // Hide table view
            self?.provincesTableView.isHidden = true
        }
        
        // Set border color to red
        searchBar.searchTextField.layer.borderColor = ThemeManager.color.searchBarBorderError?.cgColor
        
    }
    
    // MARK: - displayTableView
    func displayTableView(_ searchText: String) {
        
        // Animate displaying table view for
        // better user experience
        UIView.animate(withDuration: 1, delay: 1) { [weak self] in
            // Expose table view
            self?.provincesTableView.isHidden = false
            
            // Hide placeholder view
            self?.provinceSearchPlaceholderView?.isHidden = true
        }
        
        // If search text is empty, set border color
        // to default, otherwise set to green
        if searchText == "" {
            searchBar.searchTextField.layer.borderColor = ThemeManager.color.searchBarBorder?.cgColor
        } else {
            searchBar.searchTextField.layer.borderColor = ThemeManager.color.searchBarBorderCorrect?.cgColor
        }
        
    }
    
}
