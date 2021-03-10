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
        view?.showSpinner(isLoading: true)
        APIManager.shared.getRandomPhoto { (result) in
            switch result {
            case.success(let url):
                DispatchQueue.main.async {
                    self.view?.backgroundImage.kf.setImage(with: URL(string: url)) { (_) in
                        self.view?.showSpinner(isLoading: false)
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
                self.view?.showSpinner(isLoading: false)
            }
        }
    }
}
