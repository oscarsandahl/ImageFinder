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
            if let url = imageModel?.urls?[ImageSize.small.rawValue] {
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
        loadingIndicator.showSpinner(isLoading: true)
        image.kf.setImage(with: URL(string: imageUrl)) { (_) in
            self.loadingIndicator.showSpinner(isLoading: false)
        }
    }
}
