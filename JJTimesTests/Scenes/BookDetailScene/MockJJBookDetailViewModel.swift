//
//  MockJJBookDetailViewModel.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import Foundation
@testable import JJTimes

class MockJJBookDetailViewModel: JJBookDetailViewModel {

    var fetchBookDetailsCalled = false
    var bookImageCalled = false
    var bookTitleCalled = false
    var bookDescriptionCalled = false
    var bookAuthorCalled = false
    var bookPublisherCalled = false

    override func fetchBookDetails() {
        fetchBookDetailsCalled = true
    }

    override func bookImage() -> String {
        bookImageCalled = true
        return ""
    }

    override func bookTitle() -> String {
        bookTitleCalled = true
        return ""
    }

    override func bookDescription() -> String {
        bookDescriptionCalled = true
        return ""
    }

    override func bookAuthor() -> String {
        bookAuthorCalled = true
        return ""
    }

    override func bookPublisher() -> String {
        bookPublisherCalled = true
        return ""
    }
}
