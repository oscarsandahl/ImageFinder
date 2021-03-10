//
//  QueryGirdPresenter.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-01.
//

import Foundation

class QueryGirdPresenter {
    
    // MARK: - Variables
    weak var view: QueryGridViewController?
    var queryResult: QueryResult?
    var query: String?
    
    // MARK: - Initialization
    init(_ view: QueryGridViewController, query: String) {
        self.view = view
        self.query = query
    }
    
    // MARK: - Functions
    func fetchQuery() {
        guard let query = query else { return }
        APIManager.shared.getPhotosFromQuery(query: query, itemsPerPage: 24) { (result) in
            switch result {
            case.success(let data):
                DispatchQueue.main.async {
                    self.queryResult = data
                    self.view?.collectionView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func openExpandedPhoto(imageUrl: String?) {
        guard let imageUrl = imageUrl else { return }
        view?.openExpandedPhoto(imageUrl: imageUrl)
    }
}
