//
//  SearchPhotosPresenter.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-10.
//

import Foundation

class SearchPhotosPresenter {

    // MARK: - Variables
    weak var view: SearchPhotosViewController?

    // MARK: - Managing view
    init(_ view: SearchPhotosViewController) {
        self.view = view
    }

    // MARK: - Functions
    func fetchBackground() {
        view?.loadingIndicator.showSpinner(isLoading: true)
        APIManager.shared.fetchPhoto(fetchtype: .random) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    if let imageUrl = image.results.first?.urls?[ImageSize.full.rawValue] {
                        self.view?.backgroundImage.kf.setImage(with: URL(string: imageUrl)) { (_) in
                            self.view?.loadingIndicator.showSpinner(isLoading: false)
                        }
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
                self.view?.loadingIndicator.showSpinner(isLoading: false)
            }
        }
    }
}
