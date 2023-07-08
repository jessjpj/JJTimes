//
//  JJTopStoriesRepository.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

class JJTopStoriesRepository {
    let client: JJNetworkClient
    let cache = JJCache<JJURLWrapper, JJTopStoriesResultModel>()

    init(client: JJNetworkClient) {
        self.client = client
    }

    func fetchNews(period: Int, completion: @escaping (Result<JJTopStoriesResultModel, Error>) -> Void) {
        let baseURLString = JJAppConfiguration().mostPopularURL
        let apiKey = JJAppConfiguration().apiKEY
        let combinedURLString = baseURLString + "\(period).json?api-key=" + apiKey
        let url = URL(string: combinedURLString)!
        let wrappedURL = JJURLWrapper(url)
        if JJReachability.isConnectedToNetwork() {
            if let cachedFloors = cache.value(forKey: wrappedURL) {
                completion(.success(cachedFloors))
                return
            }
        }
        client.get(url: url) { (result: Result<JJTopStoriesResultModel, Error>) in
            switch result {
            case .success(let news):
                self.cache.insert(news, forKey: wrappedURL)
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
