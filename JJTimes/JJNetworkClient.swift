//
//  JJNetworkClient.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

protocol JJNetworkClient {
    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}
