//
//  UIImageView+Extension.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-24.
//

import UIKit

extension UIImageView {
    func fetchImageFromURL(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
                UIView.animate(withDuration: 1.0) {
                    self.alpha = 1.0
                }
            }
        }
    }
}
