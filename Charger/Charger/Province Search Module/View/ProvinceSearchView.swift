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
        
        // Set search bar view background
        searchBar.barTintColor = ThemeManager.color.background
        
        // Set search bar background
        

        // Set search bar layer color
        
        
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
        
    }
    
    // MARK: - displayTableView
    func displayTableView() {
        
        // Animate displaying table view for
        // better user experience
        UIView.animate(withDuration: 1, delay: 1) { [weak self] in
            // Expose table view
            self?.provincesTableView.isHidden = false
            
            // Hide placeholder view
            self?.provinceSearchPlaceholderView?.isHidden = true
        }
        
    }
    
}
