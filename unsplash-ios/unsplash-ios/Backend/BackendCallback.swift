//
//  BackendCallback.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-24.
//

import Foundation

typealias BackendCallback<T> = (Result<T, BackendError>) -> Void

enum BackendError: Error {
    case empty
    case error(message: String)
}
