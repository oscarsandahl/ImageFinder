//
//  ExpandedPhotoPresenter.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-04.
//

import Foundation

class ExpandedPhotoPresenter {

    // MARK: - Variables
    weak var view: ExpandedPhotoViewController?
    var imageUrl: String?

    // MARK: - Managing view
    init(_ view: ExpandedPhotoViewController, imageUrl: String) {
        self.view = view
        self.imageUrl = imageUrl
    }

    // MARK: - Functions
    func fetchImage() {
        guard let imageUrl = imageUrl else { return }
        view?.showSpinner(isLoading: true)
        view?.expandedPhoto.kf.setImage(with: URL(string: imageUrl)) { (_) in
            self.view?.showSpinner(isLoading: false)
        }
    }
}
