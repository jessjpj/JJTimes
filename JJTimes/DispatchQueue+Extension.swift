//
//  DispatchQueue+Extension.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 05/07/2023.
//

import Foundation

extension DispatchQueue: JJDispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
