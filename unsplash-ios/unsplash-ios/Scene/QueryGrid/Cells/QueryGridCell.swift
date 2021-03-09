//
//  QueryGridCell.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-01.
//

import UIKit
import Kingfisher

class QueryGridCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    static let reuseIdentifier = "QueryGridCell"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var imageModel: Image? {
        didSet {
            if let url = imageModel?.urls?["full"] {
                setImage(imageUrl: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(imageUrl: String) {
        self.showSpinner(isLoading: true)
        self.image.kf.setImage(with: URL(string: imageUrl)) { (_) in
            self.showSpinner(isLoading: false)
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
