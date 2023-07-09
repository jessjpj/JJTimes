//
//  MockJJRepository.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import Foundation
@testable import JJTimes

class MockJJRepository: JJRepository {

    var fetchCategoriesCalled = false
    var fetchBooksCalled = false
    var fetchCategoriesCompletionResult: Result<JJBooksCategoriesModel, Error>?
    var fetchBooksCompletionResult: Result<JJBooksResultsModel, Error>?
    
    override func fetchCategories(completion: @escaping (Result<JJBooksCategoriesModel, Error>) -> Void) {
        fetchCategoriesCalled = true
        if let result = fetchCategoriesCompletionResult {
            completion(result)
        }
    }

    override func fetchBooks(offset: Int, list: String, completion: @escaping (Result<JJBooksResultsModel, Error>) -> Void) {
        fetchBooksCalled = true
        if let result = fetchBooksCompletionResult {
            completion(result)
        }
    }
}
