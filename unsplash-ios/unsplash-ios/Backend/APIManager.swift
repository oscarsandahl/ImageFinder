//
//  APIManager.swift
//  unsplash-ios
//
//  Created by Sandahl, Oscar on 2021-02-22.
//

import Foundation

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
    
    func getRandomPhoto(randomPhotoCompletionHandler: @escaping (Result<String, Error>) -> Void) {
        if let url = URL(string: "\(baseUrl)\(randomPhotoEndpoint)\(getAccessKey())") {
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(Image.self, from: data)
                    if let photoDictionary = result.urls {
                        if let photoFull = photoDictionary["full"] {
                            randomPhotoCompletionHandler(.success(photoFull))
                        }
                    }
                } catch let jsonErr {
                    print("Error decoding random image:", jsonErr)
                    randomPhotoCompletionHandler(.failure(jsonErr))
                }
            }.resume()
        }
    }
    
    func getPhotosFromQuery(query: String, itemsPerPage: Int, queryPhotosCompletionHandler: @escaping BackendCallback<QueryResult>) {
        let queryUrl = "\(baseUrl)\(searchPhotoEndpoint)\(getAccessKey())&query=\(query)&per_page=\(itemsPerPage)"
        guard let url = URL(string: queryUrl) else {
            queryPhotosCompletionHandler(.failure(.empty))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                queryPhotosCompletionHandler(.failure(.empty))
                return
            }
            do {
                let result = try JSONDecoder().decode(QueryResult.self, from: data)
                queryPhotosCompletionHandler(.success(result))
            } catch let jsonError {
                print(jsonError)
                queryPhotosCompletionHandler(.failure(.error(message: "Error decoding query")))
            }
        }.resume()
    }
}
