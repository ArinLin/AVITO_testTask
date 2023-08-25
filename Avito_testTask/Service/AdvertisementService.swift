//
//  AdvertisementService.swift
//  Avito_testTask
//
//  Created by Arina on 24.08.2023.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unknown
    
    var message: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "invalid URL"
        default:
            return "Unknown error"
        }
    }
}

protocol AdvertisementServiceProtocol {
    func fetchAdvertisements(completion: @escaping(Result<AdvertisementResponse, RequestError>) -> Void)
    func fetchDetailAdvertisement(id: String, completion: @escaping(Result<Detail, RequestError>) -> Void)
}

final class AdvertisementService: AdvertisementServiceProtocol {
    static let advertisementService = AdvertisementService()
    
    func fetchAdvertisements(completion: @escaping(Result<AdvertisementResponse, RequestError>) -> Void) {
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json") else {
            completion(.failure(RequestError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response , error in
            guard let data = data, error == nil else {
                return
            }
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(RequestError.noResponse))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(AdvertisementResponse.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(.decode))
            }
        }
        task.resume()
    }
    
    func fetchDetailAdvertisement(id: String, completion: @escaping(Result<Detail, RequestError>) -> Void) {
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json") else {
            completion(.failure(RequestError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response , error in
            guard let data = data, error == nil else {
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(RequestError.noResponse))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Detail.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(.decode))
            }
        }
        task.resume()
    }
}
