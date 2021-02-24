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
    
}