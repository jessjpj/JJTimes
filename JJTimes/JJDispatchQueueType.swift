//
//  JJDispatchQueueType.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

protocol JJDispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
}
