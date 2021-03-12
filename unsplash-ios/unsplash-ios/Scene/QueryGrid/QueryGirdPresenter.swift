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
    func fetchSearch() {
        guard let search = query else { return }
        APIManager.shared.fetchPhoto(fetchtype: .search(search: search)) { (result) in
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
