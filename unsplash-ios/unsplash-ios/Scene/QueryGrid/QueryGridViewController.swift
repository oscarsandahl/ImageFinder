//
//  QueryGridViewController.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-26.
//

import UIKit

class QueryGridViewController: UIViewController {

    var collectionView: UICollectionView!
    var searchUrl: String?
    var queryResult: QueryResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        setupCollectionView()
        fetchQuery()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QueryGridCell.nib, forCellWithReuseIdentifier: QueryGridCell.reuseIdentifier)
        self.view.addSubview(collectionView)
    }
    
    func fetchQuery() {
        if let searchUrl = searchUrl {
            APIManager.shared.getPhotosFromQuery(query: searchUrl, itemsPerPage: 24) { (result) in
                switch result {
                case.success(let data):
                    DispatchQueue.main.async {
                        self.queryResult = data
                        self.collectionView.reloadData()
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension QueryGridViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let queryResult = queryResult?.results {
            return queryResult.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QueryGridCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? QueryGridCell {
            cell.showSpinner(isLoading: true)
            if let queryResult = queryResult?.results {
                if let imageUrls = queryResult[indexPath.row].urls {
                    if let image = imageUrls["full"] {
                        cell.image.fetchImageFromURL(from: image) { (result) in
                            switch result {
                            case.success():
                                cell.image.isHidden = false
                                cell.showSpinner(isLoading: false)
                            case.failure(let error):
                                print(error.localizedDescription)
                                cell.showSpinner(isLoading: false)
                            }
                        }
                    }
                }
            }
        }
        return cell
    }
}

extension QueryGridViewController: UICollectionViewDelegate {
    
}

extension QueryGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = view.frame.width/3
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
