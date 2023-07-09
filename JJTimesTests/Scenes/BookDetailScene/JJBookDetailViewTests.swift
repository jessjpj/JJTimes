//
//  JJBookDetailViewTests.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import XCTest
@testable import JJTimes

final class JJBookDetailViewTests: XCTestCase {

    var sut: JJBookDetailView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JJBookDetailView()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testSetupViewModel_CallsFetchBookDetails() {
        // Given
        let mockViewModel = MockJJBookDetailViewModel(bookDetailsRepository: MockJJRepository(), dispatchQueue: MockJJDispatchQueue(), primaryisbn10: "", bookPublishedDate: "", bookCategory: "")
        sut.bookDetailViewModel = mockViewModel
        
        // When
        sut.setupViewModel()
        
        // Then
        XCTAssertTrue(mockViewModel.fetchBookDetailsCalled)
    }
    
    func testLoadUI_UpdatesUIWithViewModelData() {
        // Given
        let mockViewModel = MockJJBookDetailViewModel(bookDetailsRepository: MockJJRepository(), dispatchQueue: MockJJDispatchQueue(), primaryisbn10: "", bookPublishedDate: "", bookCategory: "")
        sut.bookDetailViewModel = mockViewModel
        
        // When
        sut.loadUI()
        
        // Then
        XCTAssertTrue(mockViewModel.bookImageCalled)
        XCTAssertTrue(mockViewModel.bookTitleCalled)
        XCTAssertTrue(mockViewModel.bookDescriptionCalled)
        XCTAssertTrue(mockViewModel.bookAuthorCalled)
        XCTAssertTrue(mockViewModel.bookPublisherCalled)
    }
}
