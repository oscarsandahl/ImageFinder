//
//  ExpandedPhotoViewController.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-04.
//

import UIKit

class ExpandedPhotoViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var expandedPhoto: UIImageView!
    
    // MARK: - Variables
    var presenter: ExpandedPhotoPresenter!
    
    // MARK: - Initialization
    class func initViewController(imageUrl: String) -> UIViewController {
        let expandedPhotoViewController = ExpandedPhotoViewController()
        expandedPhotoViewController.presenter = ExpandedPhotoPresenter(expandedPhotoViewController, imageUrl: imageUrl)
        return expandedPhotoViewController
    }
    
    // MARK: - Managing view
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
}
