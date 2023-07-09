//
//  MockJJDispatchQueue.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import Foundation
@testable import JJTimes

final class MockJJDispatchQueue: JJDispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
