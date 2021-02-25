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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBackground()
    }
    
    func fetchBackground() {
        APIManager.shared.getRandomPhoto { (result) in
            switch result {
            case.success(let url):
                self.backgroundImage.fetchImageFromURL(from: url)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

