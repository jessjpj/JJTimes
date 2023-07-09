//
//  JJBookDetailViewModel.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import Foundation

protocol JJBookDetailViewModelDelegate: AnyObject {
    func bookDetailDidFetch()
}

class JJBookDetailViewModel {
    
    private let bookDetailsRepository: JJRepository
    private let dispatchQueue: JJDispatchQueueType
    private var primaryisbn10: String = ""
    private var bookPublishedDate: String = ""
    private var bookCategory: String = ""

    var bookDetailsModel: JJBookDetailModel? {
        didSet {
            dispatchQueue.async { [weak self] in
                self?.delegate?.bookDetailDidFetch()
            }
        }
    }

    weak var delegate: JJBookDetailViewModelDelegate?

    init(bookDetailsRepository: JJRepository, dispatchQueue: JJDispatchQueueType, primaryisbn10: String, bookPublishedDate: String, bookCategory: String) {
        self.bookDetailsRepository = bookDetailsRepository
        self.dispatchQueue = dispatchQueue
        self.primaryisbn10 = primaryisbn10
        self.bookPublishedDate = bookPublishedDate
        self.bookCategory = bookCategory
    }

    func fetchBookDetails() {
        bookDetailsRepository.fetchBookDetails(date: bookPublishedDate, list: bookCategory) { [weak self] result in
            switch result {
            case .success(let books):
                self?.bookDetailsModel = books
            case .failure(let error):
                print(error)
            }
        }
    }

    fileprivate func getBook() -> Book? {
        let book = bookDetailsModel?.results.books.first(where: { book in
            book.primaryIsbn10 == primaryisbn10
        })
        return book
    }

    func bookImage() -> String {
        return getBook()?.bookImage ?? ""
    }

    func bookTitle() -> String {
        return getBook()?.title ?? ""
    }

    func bookDescription() -> String {
        return getBook()?.description ?? ""
    }

    func bookAuthor() -> String {
        return getBook()?.author ?? ""
    }

    func bookPublisher() -> String {
        return getBook()?.publisher ?? ""
    }
}
