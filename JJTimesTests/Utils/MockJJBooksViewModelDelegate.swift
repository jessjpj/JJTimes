//
//  MockJJBooksViewModelDelegate.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import Foundation
@testable import JJTimes

class MockJJBooksViewModelDelegate: JJTopStoriesViewModelDelegate {
    
    var startLoadingCalled = false
    var stopLoadingCalled = false
    var booksDidFetchCalled = false
    var categoriesDidFetchCalled = false
    var didFailWithErrorCalled = false
    var error: Error?
    
    func startLoading() {
        startLoadingCalled = true
    }
    
    func stopLoading() {
        stopLoadingCalled = true
    }
    
    func booksDidFetch() {
        booksDidFetchCalled = true
    }
    
    func categoriesDidFetch() {
        categoriesDidFetchCalled = true
    }
    
    func newsViewModel(_ viewModel: JJBooksViewModel, didFailWithError error: Error) {
        didFailWithErrorCalled = true
        self.error = error
    }
}
