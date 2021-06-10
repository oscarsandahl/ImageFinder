//
//  ApiModelsPhoto.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-22.
//

import Foundation

struct QueryResult: Decodable {
    let total: Int?
    let total_pages: Int?
    var results: [Image]
}

struct Image: Decodable {
    let description: String?
    let urls: [String: String]?
}
