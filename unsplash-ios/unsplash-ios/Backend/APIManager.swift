//
//  APIManager.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-22.
//

import Foundation

enum FetchType {
    case random
    case search(search: String)
}

class APIManager {
    static let shared = APIManager()
    let accessKey = "EtWsatXcwQKXGTQgPNh1mQUO3HR_LoW0Z_ZpxU7y_PA"
    let secretKey = "ra95FPU6vtIexK5w0R5F59a5ILGwOY2vVMQ8QYR3yjU"
    let baseUrl = "https://api.unsplash.com/"
    let randomPhotoEndpoint = "photos/random?"
    let searchPhotoEndpoint = "search/photos?"

    func getAccessKey() -> String {
        return "client_id=\(accessKey)"
    }

    func fetchPhoto(fetchtype: FetchType, page: Int = 1, callback: @escaping BackendCallback<QueryResult>) {
        var url = URL(string: "\(baseUrl)\(randomPhotoEndpoint)\(getAccessKey())")

        if case .search(let search) = fetchtype {
            let query = "&query=\(search)"
            let page = "&page=\(page)"
            let itemPerPage = "&per_page=\(20)"
            url = URL(string: "\(baseUrl)\(searchPhotoEndpoint)\(getAccessKey())\(query)\(page)\(itemPerPage)")
        }

        guard let unwrappedUrl = url else {
            callback(.failure(.empty))
            return
        }
        URLSession.shared.dataTask(with: unwrappedUrl) { (data, _, _) in
            guard let data = data else {
                callback(.failure(.empty))
                return
            }
            do {
                switch fetchtype {
                case .random:
                    let result = try JSONDecoder().decode(Image.self, from: data)
                    callback(.success(QueryResult(total: nil, total_pages: nil, results: [result])))
                case .search:
                    let result = try JSONDecoder().decode(QueryResult.self, from: data)
                    callback(.success(result))
                }
            } catch let jsonError {
                print(jsonError)
                callback(.failure(.error(message: "Error decoding image")))
            }
        }.resume()
    }
}
