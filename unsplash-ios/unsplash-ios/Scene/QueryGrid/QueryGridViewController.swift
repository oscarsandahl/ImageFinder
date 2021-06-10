//
//  QueryGridViewController.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-26.
//

import UIKit

class QueryGridViewController: UIViewController {

    // MARK: - Variables
    var collectionView: UICollectionView!
    var presenter: QueryGirdPresenter!

    // MARK: - Initialization
    class func initViewController(query: String) -> UIViewController {
        let queryGridViewController = QueryGridViewController()
        queryGridViewController.presenter = QueryGirdPresenter(queryGridViewController, query: query)
        return queryGridViewController
    }

    // MARK: - Managing view
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.fetchSearch()
    }

    // MARK: - Functions
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QueryGridCell.nib, forCellWithReuseIdentifier: QueryGridCell.reuseIdentifier)
        view.addSubview(collectionView)
    }

    func openExpandedPhoto(imageUrl: String) {
        let expandedPhotoViewController = ExpandedPhotoViewController.initViewController(imageUrl: imageUrl)
        navigationController?.pushViewController(expandedPhotoViewController, animated: true)
    }
}

// MARK: - CollectionView data source
extension QueryGridViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let queryResult = presenter.queryResult?.results {
            return queryResult.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QueryGridCell.reuseIdentifier,
                                                      for: indexPath)
        if let cell = cell as? QueryGridCell {
            cell.imageModel = presenter.queryResult?.results[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        presenter.loadMorePhotos(indexPath: indexPath.row)
    }
}

// MARK: - CollectionView delegate
extension QueryGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openExpandedPhoto(imageUrl: presenter.queryResult?.results[indexPath.row].urls?["small"])
    }
}

// MARK: - CollectionView flow layout
extension QueryGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = view.frame.width/3
        return CGSize(width: itemSize, height: itemSize)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
