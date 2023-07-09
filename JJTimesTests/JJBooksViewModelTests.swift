//
//  JJBooksViewModelTests.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import XCTest
@testable import JJTimes

final class JJBooksViewModelTests: XCTestCase {

    var sut: JJBooksViewModel!
    var mockRepository: MockJJRepository!
    var mockDispatchQueue: MockJJDispatchQueue!
    var mockDelegate: MockJJBooksViewModelDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockJJRepository()
        mockDispatchQueue = MockJJDispatchQueue()
        sut = JJBooksViewModel(newsRepository: mockRepository, dispatchQueue: mockDispatchQueue, offset: 0, categoryName: "")
        mockDelegate = MockJJBooksViewModelDelegate()
        sut.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        sut = nil
        mockRepository = nil
        mockDispatchQueue = nil
        mockDelegate = nil
        try super.tearDownWithError()
    }
        
    func testFetchCategories_CallsRepositoryAndUpdatesCategoriesModel() {
        let mockCategories = JJBooksCategoriesModel(status: "", copyright: "", numResults: 10, results: [])
        mockRepository.fetchCategoriesCompletionResult = .success(mockCategories)
        
        sut.fetchCategories()
        
        XCTAssertTrue(mockRepository.fetchCategoriesCalled)
        XCTAssertEqual(sut.categoriesModel, mockCategories)
        XCTAssertTrue(mockDelegate.categoriesDidFetchCalled)
    }

    func testFetchBooks_WithValidOffsetAndCategory_CallsRepositoryAndUpdatesBooksModel() {
        let mockBooks = JJBooksResultsModel(numResults: 10, lastModified: "", results: [])
        let mockBooksModel = JJBooksModel(model: mockBooks)
        mockRepository.fetchBooksCompletionResult = .success(mockBooks)
        
        sut.fetchBooks()
        
        XCTAssertTrue(mockRepository.fetchBooksCalled)
        XCTAssertEqual(sut.booksModel, mockBooksModel)
        XCTAssertTrue(mockDelegate.booksDidFetchCalled)
    }
    
    func testFetchBooks_WithOffsetGreaterThanResultsCount_DoesNotCallRepository() {
        let mockBooks = JJBooksResultsModel(numResults: 10, lastModified: "", results: [])
        let mockBooksModel = JJBooksModel(model: mockBooks)
        mockRepository.fetchBooksCompletionResult = .success(mockBooks)
        sut.booksModel = mockBooksModel
        sut.offset = 10
        
        sut.fetchBooks()
        
        XCTAssertFalse(mockRepository.fetchBooksCalled)
    }
    
    func testFetchBooks_Failure_CallsDelegateWithError() {
        let mockError = NSError(domain: "MockError", code: 123, userInfo: nil)
        mockRepository.fetchBooksCompletionResult = .failure(mockError)
        
        sut.fetchBooks()
        
        XCTAssertTrue(mockRepository.fetchBooksCalled)
        XCTAssertNil(sut.booksModel)
    }
    
    func testResetBooksList_SetsOffsetToZeroAndUpdatesCategoryName() {
        sut.resetBooksList(categoryName: "test-category")
        
        XCTAssertEqual(sut.offset, 0)
        XCTAssertEqual(sut.categoryName, "test-category")
    }

    func testNumberOfBooks_ReturnsCorrectCount() {
        let mockBooks = JJBooksModel(model: JJBooksResultsModel(numResults: 5, lastModified: "", results: []))
        sut.booksModel = mockBooks
        
        let count = sut.numberOfBooks()
        
        XCTAssertEqual(count, 0)
    }

    func testBookName_AtIndexPath_ReturnsCorrectName() {
        let bookDetail = BookDetail(title: "", description: "", contributor: "", author: "", contributorNote: "", price: "", ageGroup: "", publisher: "", primaryIsbn13: "", primaryIsbn10: "")
        let results = JJBooksResult(listName: "", displayName: "", bestsellersDate: "", publishedDate: "", rank: 1, rankLastWeek: 1, weeksOnList: 1, asterisk: 1, dagger: 1, amazonProductURL: "", isbns: [], bookDetails: [bookDetail], reviews: [])
        let mockBooks = JJBooksModel(model: JJBooksResultsModel(numResults: 1, lastModified: "", results: [results]))
        sut.booksModel = mockBooks
        
        let indexPath = IndexPath(row: 0, section: 0)
        let name = sut.bookName(at: indexPath)
        
        XCTAssertEqual(name, "")
    }
    
    func testBookAbstract_AtIndexPath_ReturnsCorrectAbstract() {
        let bookDetail = BookDetail(title: "", description: "", contributor: "", author: "", contributorNote: "", price: "", ageGroup: "", publisher: "", primaryIsbn13: "", primaryIsbn10: "")
        let results = JJBooksResult(listName: "", displayName: "", bestsellersDate: "", publishedDate: "", rank: 1, rankLastWeek: 1, weeksOnList: 1, asterisk: 1, dagger: 1, amazonProductURL: "", isbns: [], bookDetails: [bookDetail], reviews: [])
        let mockBooks = JJBooksModel(model: JJBooksResultsModel(numResults: 1, lastModified: "", results: [results]))
        sut.booksModel = mockBooks
        
        let indexPath = IndexPath(row: 0, section: 0)
        let abstract = sut.bookAbstract(at: indexPath)
        
        XCTAssertEqual(abstract, "")
    }
    
    func testBookAuthoredBy_AtIndexPath_ReturnsCorrectAuthor() {
        let bookDetail = BookDetail(title: "", description: "", contributor: "", author: "", contributorNote: "", price: "", ageGroup: "", publisher: "", primaryIsbn13: "", primaryIsbn10: "")
        let results = JJBooksResult(listName: "", displayName: "", bestsellersDate: "", publishedDate: "", rank: 1, rankLastWeek: 1, weeksOnList: 1, asterisk: 1, dagger: 1, amazonProductURL: "", isbns: [], bookDetails: [bookDetail], reviews: [])
        let mockBooks = JJBooksModel(model: JJBooksResultsModel(numResults: 1, lastModified: "", results: [results]))
        sut.booksModel = mockBooks
        
        let indexPath = IndexPath(row: 0, section: 0)
        let author = sut.bookAuthoredBy(at: indexPath)
        
        XCTAssertEqual(author, "")
    }
    
    func testBookPublishedBy_AtIndexPath_ReturnsCorrectPublisher() {
        let bookDetail = BookDetail(title: "", description: "", contributor: "", author: "", contributorNote: "", price: "", ageGroup: "", publisher: "", primaryIsbn13: "", primaryIsbn10: "")
        let results = JJBooksResult(listName: "", displayName: "", bestsellersDate: "", publishedDate: "", rank: 1, rankLastWeek: 1, weeksOnList: 1, asterisk: 1, dagger: 1, amazonProductURL: "", isbns: [], bookDetails: [bookDetail], reviews: [])
        let mockBooks = JJBooksModel(model: JJBooksResultsModel(numResults: 1, lastModified: "", results: [results]))
        sut.booksModel = mockBooks
        
        let indexPath = IndexPath(row: 0, section: 0)
        let publisher = sut.bookPublishedBy(at: indexPath)
        
        XCTAssertEqual(publisher, "")
    }
    
    func testBookPrimaryisbn10_AtIndexPath_ReturnsCorrectIsbn10() {
        let bookDetail = BookDetail(title: "", description: "", contributor: "", author: "", contributorNote: "", price: "", ageGroup: "", publisher: "", primaryIsbn13: "", primaryIsbn10: "")
        let results = JJBooksResult(listName: "", displayName: "", bestsellersDate: "", publishedDate: "", rank: 1, rankLastWeek: 1, weeksOnList: 1, asterisk: 1, dagger: 1, amazonProductURL: "", isbns: [], bookDetails: [bookDetail], reviews: [])
        let mockBooks = JJBooksModel(model: JJBooksResultsModel(numResults: 1, lastModified: "", results: [results]))
        sut.booksModel = mockBooks
        
        let indexPath = IndexPath(row: 0, section: 0)
        let isbn10 = sut.bookPrimaryisbn10(at: indexPath)
        
        XCTAssertEqual(isbn10, "")
    }
    
    func testBookPublishDate_AtIndexPath_ReturnsCorrectPublishDate() {
        let bookResult = JJBooksResult(listName: "", displayName: "", bestsellersDate: "", publishedDate: "2023-07-09", rank: 1, rankLastWeek: 1, weeksOnList: 1, asterisk: 1, dagger: 1, amazonProductURL: "", isbns: [], bookDetails: [], reviews: [])
        let bookResultModel = JJBooksResultsModel(numResults: 1, lastModified: "", results: [bookResult])
        let mockBooks = JJBooksModel(model: bookResultModel)
        sut.booksModel = mockBooks
        
        let indexPath = IndexPath(row: 0, section: 0)
        let publishDate = sut.bookPublishDate(at: indexPath)
        
        XCTAssertEqual(publishDate, "2023-07-09")
    }

}
