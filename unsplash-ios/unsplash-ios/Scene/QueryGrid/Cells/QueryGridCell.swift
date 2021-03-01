//
//  QueryGridCell.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-01.
//

import UIKit

class QueryGridCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    static let reuseIdentifier = "QueryGridCell"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
