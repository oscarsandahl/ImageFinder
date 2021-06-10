//
//  LoadingIndicator.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-06-10.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func showSpinner(isLoading: Bool) {
        if isLoading {
            self.startAnimating()
            self.isHidden = false
        } else {
            self.isHidden = true
            self.stopAnimating()
        }
    }
}
