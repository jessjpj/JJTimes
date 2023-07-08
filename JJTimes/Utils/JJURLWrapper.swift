//
//  JJURLWrapper.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

class JJURLWrapper: Hashable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    static func == (lhs: JJURLWrapper, rhs: JJURLWrapper) -> Bool {
        return lhs.url == rhs.url
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
}
