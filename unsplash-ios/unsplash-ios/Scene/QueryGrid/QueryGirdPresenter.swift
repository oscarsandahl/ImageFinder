//
//  QueryGirdPresenter.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-03-01.
//

import Foundation

class QueryGirdPresenter {
    weak var view: QueryGridViewController?
    var queryResult: QueryResult?
    var query: String?
    
    init(_ view: QueryGridViewController, query: String) {
        self.view = view
        self.query = query
    }
    
    func fetchQuery() {
        if let query = query {
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
    }
}
