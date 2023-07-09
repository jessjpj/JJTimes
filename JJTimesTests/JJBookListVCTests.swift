//
//  JJBookListVCTests.swift
//  JJTimesTests
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import XCTest
@testable import JJTimes

final class JJBookListVCTests: XCTestCase {

    var sut: JJBookListVC!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JJBookListVC()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testViewDidLoad_AddsBooksView() {
        XCTAssertNotNil(sut.topStoriesView)
        XCTAssertTrue(sut.view.subviews.contains(sut.topStoriesView!))
    }

    func testAddBooksView_AddsTopStoriesViewToViewControllerView() {
        sut.addBooksView()
        XCTAssertNotNil(sut.topStoriesView)
        XCTAssertTrue(sut.view.subviews.contains(sut.topStoriesView!))
    }

    func testAddBooksView_SetsTopStoriesViewConstraints() {
        sut.addBooksView()
        XCTAssertEqual(sut.topStoriesView?.superview, sut.view)
        XCTAssertEqual(sut.topStoriesView?.frame, CGRect.zero)
    }

    func testSetupUI_SetsUpTitleLabelCorrectly() {
        XCTAssertNotNil(sut.topStoriesView?.titleLabel)
        XCTAssertEqual(sut.topStoriesView?.titleLabel.text, "NY Times Most Popular Books")
        XCTAssertEqual(sut.topStoriesView?.titleLabel.font, .systemFont(ofSize: 24))
        XCTAssertEqual(sut.topStoriesView?.titleLabel.textAlignment, .center)
    }

    func testSetupUI_SetsUpUnderlineLabelCorrectly() {
        XCTAssertNotNil(sut.topStoriesView?.underlineLabel)
        XCTAssertEqual(sut.topStoriesView?.underlineLabel.backgroundColor, UIColor(named: "jjAppBlackColor"))
    }

    func testSetupUI_SetsUpFilterImageViewCorrectly() {
        XCTAssertNotNil(sut.topStoriesView?.filterImageView)
        XCTAssertEqual(sut.topStoriesView?.filterImageView.tintColor, UIColor(named: "jjAppBlackColor"))
        XCTAssertEqual(sut.topStoriesView?.filterImageView.image, UIImage(named: "jjFilterIcon"))
        XCTAssertEqual(sut.topStoriesView?.filterImageView.contentMode, .scaleAspectFit)
    }

    func testSetupUI_SetsUpFilterButtonCorrectly() {
        XCTAssertNotNil(sut.topStoriesView?.filterImageButton)
        XCTAssertNotNil(sut.topStoriesView?.filterDropDown)
        XCTAssertEqual(sut.topStoriesView?.filterImageButton.allTargets.count, 1)
    }

    func testTableViewDataSource_NumberOfRowsInSection_ReturnsCorrectCount() {
        sut.topStoriesView?.booksViewModel.booksModel = JJBooksModel(model: JJBooksResultsModel(numResults: 3, lastModified: "", results: []))
        
        let tableView = sut.topStoriesView?.bookListTableView
        let numberOfRows = sut.topStoriesView?.tableView(tableView!, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func testTableViewDataSource_CellForRowAt_ReturnsCorrectCell() {
        sut.topStoriesView?.booksViewModel.booksModel = JJBooksModel(model: JJBooksResultsModel(numResults: 1, lastModified: "", results: [JJBooksResult(listName: "", displayName: "", bestsellersDate: "", publishedDate: "", rank: 1, rankLastWeek: 1, weeksOnList: 1, asterisk: 1, dagger: 1, amazonProductURL: "", isbns: [], bookDetails: [], reviews: [])]))
        
        let tableView = sut.topStoriesView?.bookListTableView
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.topStoriesView?.tableView(tableView!, cellForRowAt: indexPath) as? JJBookTVC
        
        XCTAssertNotNil(cell)
    }
    
    func testTableViewDelegate_WillDisplayCell_LoadsMoreBooksWhenNearEnd() {
        sut.topStoriesView?.booksViewModel.booksModel = JJBooksModel(model: JJBooksResultsModel(numResults: 20, lastModified: "", results: []))
        
        let tableView = sut.topStoriesView?.bookListTableView
        let indexPath = IndexPath(row: 19, section: 0)
        sut.topStoriesView?.tableView(tableView!, willDisplay: UITableViewCell(), forRowAt: indexPath)
        
        XCTAssertEqual(sut.topStoriesView?.booksViewModel.offset, 20)
    }
}
