//
//  JJBooksRepository.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

class JJBooksRepository {
    let client: JJNetworkClient
    let cache = JJCache<JJURLWrapper, JJBooksResultsModel>()

    init(client: JJNetworkClient) {
        self.client = client
    }

    func fetchBooks(offset: Int, list: String, completion: @escaping (Result<JJBooksResultsModel, Error>) -> Void) {
        let baseURLString = JJAppConfiguration().mostPopularBooksURL
        let apiKey = JJAppConfiguration().apiKEY
        let combinedURLString = baseURLString + "/lists.json?api-key=" + apiKey + "&offset=\(offset)&list=\(list)"
        let url = URL(string: combinedURLString)!
        let wrappedURL = JJURLWrapper(url)
        if JJReachability.isConnectedToNetwork() {
            if let cachedFloors = cache.value(forKey: wrappedURL) {
                completion(.success(cachedFloors))
                return
            }
        }
        client.get(url: url) { (result: Result<JJBooksResultsModel, Error>) in
            switch result {
            case .success(let books):
                self.cache.insert(books, forKey: wrappedURL)
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchCategories(completion: @escaping (Result<JJBooksCategoriesModel, Error>) -> Void) {
        let baseURLString = JJAppConfiguration().mostPopularBooksURL
        let apiKey = JJAppConfiguration().apiKEY
        let combinedURLString = baseURLString + "/lists/names.json?api-key=" + apiKey
        let url = URL(string: combinedURLString)!
        client.get(url: url) { (result: Result<JJBooksCategoriesModel, Error>) in
            switch result {
            case .success(let categories):
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchBookDetails(date: String, list: String, completion: @escaping (Result<JJBookDetailModel, Error>) -> Void) {
        let baseURLString = JJAppConfiguration().mostPopularBooksURL
        let apiKey = JJAppConfiguration().apiKEY
        let combinedURLString = baseURLString + "/lists/\(date)/\(list).json?api-key=" + apiKey
        let url = URL(string: combinedURLString)!
        client.get(url: url) { (result: Result<JJBookDetailModel, Error>) in
            switch result {
            case .success(let categories):
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
