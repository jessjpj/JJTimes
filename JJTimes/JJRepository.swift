//
//  JJRepository.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

public class JJRepository {

    let client = JJNetworkClientImpl()

    public init() {}

    public func fetchNews(period: Int, completion: @escaping (Result<JJTopStoriesResultModel, Error>) -> Void) {
        let repository = JJTopStoriesRepository(client: client)
        repository.fetchNews(period: period) { result in
            completion(result)
        }
    }
}
