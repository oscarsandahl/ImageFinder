//
//  ExpandedPhotoPresenter.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-04.
//

import Foundation

class ExpandedPhotoPresenter {
    weak var view: ExpandedPhotoViewController?
    var imageUrl: String?
    
    init(_ view: ExpandedPhotoViewController, imageUrl: String) {
        self.view = view
        self.imageUrl = imageUrl
    }
    
    func fetchImage() {
        guard let imageUrl = imageUrl else { return }
        view?.showSpinner(isLoading: true)
        view?.expandedPhoto.fetchImageFromURL(from: imageUrl) { (_) in
            self.view?.showSpinner(isLoading: false)
        }
    }
}
