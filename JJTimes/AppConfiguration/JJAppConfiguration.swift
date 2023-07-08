//
//  JJAppConfiguration.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

final class JJAppConfiguration {
    lazy var mostPopularBooksURL: String = {
        guard let mostPopularBooksURL = Bundle.main.object(forInfoDictionaryKey: "MostPopularBooksURL") as? String else {
            fatalError("MostPopularBooksURL must not be empty in plist")
        }
        return mostPopularBooksURL
    }()
    lazy var apiKEY: String = {
        guard let apiKEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("apiKEY must not be empty in plist")
        }
        return apiKEY
    }()
}
