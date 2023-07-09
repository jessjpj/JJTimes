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
        let apiKEY = apiKeys.first ?? ""
        apiKeys.removeFirst()
        apiKeys.append(apiKEY)
        return apiKEY
    }()
}
// work around to fetch the api's as the nytimes restrict the usage of api calls using the apikey 4 times a minute
var apiKeys = ["j3NUZk32eA9SoLn3lo4HWfUSRM0ba3G3", "IINdwaUD0vhe9k7B18fwy7FnZ05DUUMo", "V0M6Neu415DKhVk65hqjSu7w50jO4CtT", "16xi24ZXB2sE60QXla02aQH7NiVKAlXa", "mciCt4ZwycfC9WjB5WLQOM7MqpCRdjpo"]
