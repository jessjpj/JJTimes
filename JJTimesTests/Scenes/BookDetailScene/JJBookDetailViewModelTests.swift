//
//  JJBookDetailViewModelTests.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import XCTest
@testable import JJTimes

final class JJBookDetailViewModelTests: XCTestCase {

    var sut: JJBookDetailViewModel!
    var mockBookDetailsRepository: MockJJRepository!
    var mockDispatchQueue: MockJJDispatchQueue!
    var mockDelegate: MockJJBookDetailViewModelDelegate!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockBookDetailsRepository = MockJJRepository()
        mockDispatchQueue = MockJJDispatchQueue()
        mockDelegate = MockJJBookDetailViewModelDelegate()
        sut = JJBookDetailViewModel(
            bookDetailsRepository: mockBookDetailsRepository,
            dispatchQueue: mockDispatchQueue,
            primaryisbn10: "",
            bookPublishedDate: "",
            bookCategory: ""
        )
        sut.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        sut = nil
        mockBookDetailsRepository = nil
        mockDispatchQueue = nil
        mockDelegate = nil
        try super.tearDownWithError()
    }

    func testFetchBookDetails_CallsDelegateMethods() {
        // Given
        let mockBooksModel = JJBookDetailModel(numResults: 0, results: JJBookDetailResults(
            listName: "",
            listNameEncoded: "",
            bestsellersDate: "",
            publishedDate: "",
            publishedDateDescription: "",
            nextPublishedDate: "",
            previousPublishedDate: "",
            displayName: "",
            normalListEndsAt: 0,
            updated: "",
            books: [],
            corrections: []
        ))
        mockBookDetailsRepository.fetchBookDetailCompletionResult = .success(mockBooksModel)
        
        // When
        sut.fetchBookDetails()
        
        // Then
        XCTAssertTrue(mockDelegate.startLoadingCalled)
        XCTAssertTrue(mockDelegate.stopLoadingCalled)
        XCTAssertTrue(mockDelegate.bookDetailDidFetchCalled)
    }
    
    func testFetchBookDetails_CallsDelegateMethodsOnError() {
        // Given
        let mockError = NSError(domain: "TestError", code: 0, userInfo: nil)
        mockBookDetailsRepository.fetchBookDetailCompletionResult = .failure(mockError)
        
        // When
        sut.fetchBookDetails()
        
        // Then
        XCTAssertTrue(mockDelegate.startLoadingCalled)
        XCTAssertTrue(mockDelegate.stopLoadingCalled)
        XCTAssertFalse(mockDelegate.bookDetailDidFetchCalled)
    }

}
