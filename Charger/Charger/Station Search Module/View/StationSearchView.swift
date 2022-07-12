//
//  StationSearchView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 12.07.2022.
//

import UIKit

class StationSearchView: UIViewController {
    
    @IBOutlet private var superView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var filtersCollectionView: UICollectionView!
    @IBOutlet private weak var stationsInfoLabel: UILabel!
    @IBOutlet private weak var stationsTableView: UITableView!
    
    // MARK: - Properties
    var province: String?
    
    var stationsInProvince = [Station]()
    
    var filterChoices = [Filter]()
    
    var isFilterChoicesEmpty: Bool!
    
    var stationSearchPresenter: StationSearchContract.stationSearchPresenter?
    
    var stationsTableViewHelper: StationsTableViewHelper!
    
    // Filter bar button initialized as global property
    // to be able to change it's color later on
    var filterBarButton: UIBarButtonItem?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up ui componenets
        setupUI()
        
        // Call viewDidLoad in presenter
        stationSearchPresenter?.viewDidLoad()
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        // Call viewWillAppear in presenter
        stationSearchPresenter?.viewWillAppear()
    }

}

// Setting up ui components
extension StationSearchView {
    
    /**
     SetupUI method does setup UI as its name implies.
     It prepares UI components to conform to zeplin guideline
     of the project.
     
     -returns: None
     */
    // MARK: - setupUI
    private func setupUI() {
        
        // Set navigation bar
        setNavigationBar()
        
        // Set search bar
        setSearchBar()
        
        // Set stations info label
        setStationsInfoLabel()
        
        // Initialize stations table view helper
        stationsTableViewHelper = .init(stationsTableView,
                                        stationSearchPresenter!,
                                        self)
        
        // Initialize filters collection view helper
        
        
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        // Set navigation title
        setNavigationTitle()
        
        // Set navigation filer bar button
        setNavigationFilterBarButton()
    }
    
    // MARK: - setNavigationTitle
    private func setNavigationTitle() {
        
        // Create navigation title's attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        
        // Create navigation bar's appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = ThemeManager.color.navigationBackground
        appearance.titleTextAttributes = attributes
        
        // Set navigation bar appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        // Set navigation bar title
        title = "İstasyon Seçin"
    }
    
    // MARK: - setNavigationFilterBarButton
    private func setNavigationFilterBarButton() {
        
        // Create bar button item
        filterBarButton = UIBarButtonItem(image: .init(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(didPressFilterBarButton))
        
        // Set filter bar button color
        filterBarButton?.tintColor = ThemeManager.color.searchBarBorder
        
        // Set bar button item
        navigationItem.rightBarButtonItem = filterBarButton
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
        searchBar.placeholder = "İstasyon Ara"
        
    }
    
    // MARK: - setStationsInfoLabel
    private func setStationsInfoLabel() {
        
        // Unwrap province
        guard let province = province else { return }
        
        // Create first part of attributes
        let firstPartAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        let firstPartString = "'\(province)'"
        let firstPart = NSMutableAttributedString(string: firstPartString,
                                                  attributes: firstPartAttributes)
        
        // Get number of stations in province result
        let numberOfResult = stationsInProvince.count
        
        // Create second part of attributes
        let secondPartAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: ThemeManager.color.title!
        ]
        let secondPartString = " şehri için \(numberOfResult) sonuç görüntüleniyor."
        let secondPart = NSAttributedString(string: secondPartString,
                                            attributes: secondPartAttributes)
        
        // Concatenate both of parts
        firstPart.append(secondPart)
        
        // Assign concatenated parts into label
        stationsInfoLabel.attributedText = firstPart
        
    }

}

// Self related methods
extension StationSearchView: StationSearchContract.stationSearchView {
    
    // MARK: - updateStationsTableView
    func updateStationsTableView(_ stationsInProvince: [Station]) {
        
        // Assign this class' stationsInProvince property as well
        // for the stationsInfoLabel
        self.stationsInProvince = stationsInProvince
        
        // Call stations table view helper to show stations in table view
        stationsTableViewHelper.set(stationsInProvince: stationsInProvince)
    }
    
    // MARK: - displayFiltersCollectionView
    func displayFiltersCollectionView() {
        
        // Animate displaying collection view for
        // better user experience
        UIView.animate(withDuration: 0.25, delay: 0.25) { [weak self] in
            
            // Display filters collection view
            self?.filtersCollectionView.isHidden = false
            
        }
        
        // If filter choices array is empty, assign green color to
        // filter bar button
        if !isFilterChoicesEmpty {
            filterBarButton?.tintColor = ThemeManager.color.chosenCellBorder
        }
        
    }
    
    // MARK: - hideFiltersCollectionView
    func hideFiltersCollectionView() {
        
        // Animate hiding collection view for
        // better user experience
        UIView.animate(withDuration: 0.25, delay: 0.25) { [weak self] in
            
            // Hide filters collection view
            self?.filtersCollectionView.isHidden = true
            
        }
        
        // If filter choices array is not empty, assign default color
        // to filter bar button
        if isFilterChoicesEmpty {
            filterBarButton?.tintColor = ThemeManager.color.searchBarBorder
        }
        
    }
    
}

// Search bar related methods
extension StationSearchView: UISearchBarDelegate {
    
    // MARK: - searchBarTextDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Call didEditSearchText method in presenter for notifying
        // that search text was changed by the user
        stationSearchPresenter?.didEditSearchText(with: searchText)
    }
    
}

// @objc methods
extension StationSearchView {
    
    // MARK: - didPressFilterBarButton
    @objc private func didPressFilterBarButton() {
        // Call didPressFilterBarButton in presenter to navigate to the page
        stationSearchPresenter?.didPressFilterBarButton(self, filterChoices)
    }
    
}

