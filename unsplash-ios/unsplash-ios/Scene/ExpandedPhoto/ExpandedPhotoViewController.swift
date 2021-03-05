//
//  ExpandedPhotoViewController.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-04.
//

import UIKit

class ExpandedPhotoViewController: UIViewController {
    
    // MARK: - Constants
    private static let storyboardName = "Main"
    private static let viewControllerIdentifier = "ExpandedPhotoId"
    
    // MARK: - Outlets
    @IBOutlet weak var expandedPhoto: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var presenter: ExpandedPhotoPresenter!
    
    // MARK: - Initialization
    class func initViewController(imageUrl: String) -> UIViewController {
        let storyboard = UIStoryboard(name: ExpandedPhotoViewController.storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ExpandedPhotoViewController.viewControllerIdentifier)
        
        if let overviewViewController = viewController as? ExpandedPhotoViewController {
            overviewViewController.presenter = ExpandedPhotoPresenter(overviewViewController, imageUrl: imageUrl)
            
        }
        
        return viewController
    }
    
    // MARK: - Managing view
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchImage()
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
