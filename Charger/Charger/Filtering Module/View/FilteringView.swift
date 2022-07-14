//
//  FilteringView.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 14.07.2022.
//

import UIKit

class FilteringView: UIViewController, FilteringContract.filteringView {

    @IBOutlet var superView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterTypesTableView: UITableView!
    @IBOutlet weak var filtreleButton: UIButton!
    
    // MARK: - Properties
    var filteringPresenter: FilteringContract.filteringPresenter?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up ui componenets
        setupUI()
        
        // Call viewDidLoad in presenter
        filteringPresenter?.viewDidLoad()
        
    }

    @IBAction func didPressFiltreleButton(_ sender: Any) {
        filteringPresenter?.didPressFilterButton(self)
    }
}

// Setting up ui components
extension FilteringView {
    
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
        
        // Set filtrele button
        setFiltreleButton()
        
        // Initialize filter types table view helper
        
        
    }
    
    // MARK: - setBackgroundViews
    private func setBackgroundViews() {
        // Set super view's background color
        superView.backgroundColor = ThemeManager.color.navigationBackground
        
        // Set container view's background color
        containerView.backgroundColor = ThemeManager.color.background
        
        // Set table view's backgorund color
        filterTypesTableView.backgroundColor = ThemeManager.color.background
    }
    
    // MARK: - setNavigationBar
    private func setNavigationBar() {
        
        // Set navigation back bar button
        setNavigationBackBarButton()
        
        // Set navigation title
        setNavigationTitle()
        
        // Set navigation temizle bar button
        setNavigationTemizleBarButton()
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
        title = "Filtreleme"
        
    }
    
    // MARK: - setNavigationTemizleBarButton
    private func setNavigationTemizleBarButton() {
        
        // Create bar button item
        let filterBarButton = UIBarButtonItem(title: "Temizle", style: .plain, target: self, action: #selector(didPressTemizleBarButton))
        
        // Set temizle bar button's color
        filterBarButton.tintColor = ThemeManager.color.title!
        
        // Set bar button item
        navigationItem.rightBarButtonItem = filterBarButton
        
    }
    
    // MARK: - setFiltreleButton
    private func setFiltreleButton() {
        filtreleButton.titleLabel?.isHidden = true
        filtreleButton.configuration = .plain()
        filtreleButton.setImage(ThemeManager.image.buttonFiltrele,
                                for: .normal)
    }
    
}

// Self related methods
extension FilteringView {
    
    // MARK: - setFilterTypesTableView
    func setFilterTypesTableView(with filterTypes: [FilterType]) {
        
    }
    
    // MARK: - reloadFilterTypesTableView
    func reloadFilterTypesTableView() {
        filterTypesTableView.reloadData()
    }
    
}

// @objc methods
extension FilteringView {
    
    // MARK: - didPressTemizleBarButton
    @objc private func didPressTemizleBarButton() {
        filteringPresenter?.didPressTemizleBarButton()
    }
    
}
