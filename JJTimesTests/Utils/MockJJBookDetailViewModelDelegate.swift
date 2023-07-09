//
//  MockJJBookDetailViewModelDelegate.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import Foundation
@testable import JJTimes

class MockJJBookDetailViewModelDelegate: JJBookDetailViewModelDelegate {

    var startLoadingCalled = false
    var stopLoadingCalled = false
    var bookDetailDidFetchCalled = false

    func startLoading() {
        startLoadingCalled = true
    }

    func stopLoading() {
        stopLoadingCalled = true
    }

    func bookDetailDidFetch() {
        bookDetailDidFetchCalled = true
    }
}
