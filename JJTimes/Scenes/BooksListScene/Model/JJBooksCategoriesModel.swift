//
//  JJBooksCategoriesModel.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 08/07/2023.
//

import Foundation

// MARK: - JJBooksCategoriesResult
public struct JJBooksCategoriesModel: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [JJBooksCategoriesResult]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
struct JJBooksCategoriesResult: Codable {
    let listName, displayName, listNameEncoded, oldestPublishedDate: String
    let newestPublishedDate, updated: String

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
        case updated
    }
}
