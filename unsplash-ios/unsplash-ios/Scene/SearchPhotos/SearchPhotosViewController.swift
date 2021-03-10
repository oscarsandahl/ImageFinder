//
//  ViewController.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-22.
//

import UIKit
import Kingfisher

class SearchPhotosViewController: UIViewController {
    
    // MARK: - Constants
    private static let storyboardName = "Main"
    private static let viewControllerIdentifier = "SearchPhotosId"

    // MARK: - Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var presenter: SearchPhotosPresenter!
    
    // MARK: - Initialization
    class func initViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: SearchPhotosViewController.storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: SearchPhotosViewController.viewControllerIdentifier)
        
        if let searchPhotosViewController = viewController as? SearchPhotosViewController {
            searchPhotosViewController.presenter = SearchPhotosPresenter(searchPhotosViewController)
            
        }
        
        return viewController
    }
    
    // MARK: - Managing view
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchBackground()
    }
    
    // MARK: - Functions
    func fetchBackground() {
        showSpinner(isLoading: true)
        APIManager.shared.getRandomPhoto { (result) in
            switch result {
            case.success(let url):
                DispatchQueue.main.async {
                    self.backgroundImage.kf.setImage(with: URL(string: url)) { (_) in
                        self.showSpinner(isLoading: false)
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
                self.showSpinner(isLoading: false)
            }
        }
    }
    
    func showSpinner(isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
        } else {
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
        }
    }
    
}

// MARK: - Searchbar delegate
extension SearchPhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            let queryGridViewController = QueryGridViewController.initViewController(query: query)
            navigationController?.pushViewController(queryGridViewController, animated: true)
        }
    }
}
