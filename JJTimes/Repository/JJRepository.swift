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

    public func fetchBooks(offset: Int, list: String, completion: @escaping (Result<JJBooksResultsModel, Error>) -> Void) {
        let repository = JJBooksRepository(client: client)
        repository.fetchBooks(offset: offset, list: list) { result in
            completion(result)
        }
    }

    public func fetchCategories(completion: @escaping (Result<JJBooksCategoriesModel, Error>) -> Void) {
        let repository = JJBooksRepository(client: client)
        repository.fetchCategories { categories in
            completion(categories)
        }
    }
}
