//
//  QueryGridViewController.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-26.
//

import UIKit

class QueryGridViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

}
