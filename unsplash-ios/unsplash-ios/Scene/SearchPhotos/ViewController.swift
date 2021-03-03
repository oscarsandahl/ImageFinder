//
//  ViewController.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchBackground()
    }
    
    func fetchBackground() {
        showSpinner(isLoading: true)
        APIManager.shared.getRandomPhoto { (result) in
            switch result {
            case.success(let url):
                self.backgroundImage.fetchImageFromURL(from: url) { (_) in
                    self.showSpinner(isLoading: false)
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

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            let queryGridViewController = QueryGridViewController.initViewController(query: query)
            navigationController?.pushViewController(queryGridViewController, animated: true)
        }
    }
}
