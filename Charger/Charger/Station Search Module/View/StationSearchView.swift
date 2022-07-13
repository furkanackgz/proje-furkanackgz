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
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var province: String?
    
    // Add property observer for stations info label
    // to be able to get set number of stations without
    // error
    var stationsInProvince = [Station]() {
        didSet {
            setStationsInfoLabel()
        }
    }
    
    var stationSearchPresenter: StationSearchContract.stationSearchPresenter?
    
    var stationsTableViewHelper: StationsTableViewHelper!
    
    var filtersCollectionViewHelper: FiltersCollectionViewHelper!
    
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
        
        // Set background views
        setBackgroundViews()
        
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
        filtersCollectionViewHelper = .init(filtersCollectionView,
                                            stationSearchPresenter!)
        
    }
    
    // MARK: - setBackgroundViews
    private func setBackgroundViews() {
        // Set super view's background color
        superView.backgroundColor = ThemeManager.color.navigationBackground
        
        // Set container view's background color
        containerView.backgroundColor = ThemeManager.color.background
        
        // Set table view's backgorund color
        stationsTableView.backgroundColor = ThemeManager.color.background
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        
        // Set navigation back bar button
        setNavigationBackBarButton()
        
        // Set navigation title
        setNavigationTitle()
        
        // Set navigation filer bar button
        setNavigationFilterBarButton()
    }
    
    // MARK: - setNavigationBackBarButton
    private func setNavigationBackBarButton() {
        
        // Set navigation back bar button
        navigationController?.navigationBar.tintColor = ThemeManager.color.title
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        
    }
    
    // MARK: - setNavigationTitle
    private func setNavigationTitle() {
        
        // Create navigation title's attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: ThemeManager.color.title!
        ]
        
        // Set navigation bar title
        navigationController?.navigationBar.titleTextAttributes = attributes
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
    
    // MARK: updateFiltersCollectionView
    func updateFiltersCollectionView(with filterChoices: [Filter]) {
        
        // Call filters collection view helper to show filter on
        // collection view
        filtersCollectionViewHelper.set(filterChoices: filterChoices)
        
    }
    
    // MARK: - displayFiltersCollectionView
    func displayFiltersCollectionView() {
        
        // Animate displaying collection view for
        // better user experience
        UIView.animate(withDuration: 0.25, delay: 0.25) { [weak self] in
            
            // Display filters collection view
            self?.filtersCollectionView.isHidden = false
            
            // Set collection view height constraint back to 50
            self?.collectionViewHeightConstraint.constant = 50
            
        }
        
        // Assign green color to filter bar button
        filterBarButton?.tintColor = ThemeManager.color.chosenCellBorder
        
    }
    
    // MARK: - hideFiltersCollectionView
    func hideFiltersCollectionView() {
        
        // Animate hiding collection view for
        // better user experience
        UIView.animate(withDuration: 0.25, delay: 0.25) { [weak self] in
            
            // Hide filters collection view
            self?.filtersCollectionView.isHidden = true
            
            // Set collection view height constraint to 0
            self?.collectionViewHeightConstraint.constant = 0
            
        }
        
        // Assign default color to filter bar button
        filterBarButton?.tintColor = ThemeManager.color.searchBarBorder
        
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
        stationSearchPresenter?.didPressFilterBarButton(self)
    }
    
}

