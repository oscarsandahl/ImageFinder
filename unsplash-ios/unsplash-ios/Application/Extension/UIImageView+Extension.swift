//
//  UIImageView+Extension.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-24.
//

import UIKit

extension UIImageView {
    func fetchImageFromURL(from url: String, callback: @escaping BackendCallback<Void>) {
        guard let imageURL = URL(string: url) else {
            callback(.failure(.empty))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                callback(.failure(.empty))
                return
            }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
                callback(.success(()))
                UIView.animate(withDuration: 1.0) {
                    self.alpha = 1.0
                }
            }
        }
    }
}
