//
//  QueryGridCell.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-01.
//

import UIKit
import Kingfisher

class QueryGridCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Variables
    static let reuseIdentifier = "QueryGridCell"

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    var imageModel: Image? {
        didSet {
            if let url = imageModel?.urls?["small"] {
                setImage(imageUrl: url)
            }
        }
    }

    // MARK: - Managing view
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Functions
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
