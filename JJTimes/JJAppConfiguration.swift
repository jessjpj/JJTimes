//
//  JJAppConfiguration.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

final class JJAppConfiguration {
    lazy var mostPopularURL: String = {
        guard let mostPopularURL = Bundle.main.object(forInfoDictionaryKey: "MostPopularURL") as? String else {
            fatalError("mostPopularURL must not be empty in plist")
        }
        return mostPopularURL
    }()
    lazy var apiKEY: String = {
        guard let apiKEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("apiKEY must not be empty in plist")
        }
        return apiKEY
    }()
}
