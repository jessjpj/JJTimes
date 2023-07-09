//
//  JJBooksViewModel.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

protocol JJTopStoriesViewModelDelegate: AnyObject {
    func booksDidFetch()
    func categoriesDidFetch()
}

class JJBooksViewModel {

    private let booksRepository: JJRepository
    private let dispatchQueue: JJDispatchQueueType
    private var offset: Int
    var categoryName: String
    private var isFetching = false

    var booksModel: JJBooksModel? {
        didSet {
            dispatchQueue.async { [weak self] in
                self?.delegate?.booksDidFetch()
            }
        }
    }

    var categoriesModel: JJBooksCategoriesModel? {
        didSet {
            dispatchQueue.async { [weak self] in
                self?.offset = 0
                self?.categoryName = self?.categoriesModel?.results[0].listNameEncoded ?? ""
                self?.delegate?.categoriesDidFetch()
                self?.fetchBooks()
            }
        }
    }

    weak var delegate: JJTopStoriesViewModelDelegate?

    init(newsRepository: JJRepository, dispatchQueue: JJDispatchQueueType, offset: Int, categoryName: String) {
        self.booksRepository = newsRepository
        self.dispatchQueue = dispatchQueue
        self.offset = offset
        self.categoryName = categoryName
    }

    func fetchCategories() {
        booksRepository.fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categoriesModel = categories
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchBooks() {
        if isFetching || ((booksModel?.books?.numResults ?? 0) < 20 && offset > 0) {
            return
        }
        isFetching = true
        booksRepository.fetchBooks(offset: offset, list: categoryName) { [weak self] result in
            self?.isFetching = false
            switch result {
            case .success(let books):
                if self?.offset == 0 {
                    self?.booksModel = JJBooksModel(model: books)
                } else {
                    self?.booksModel?.books?.results.append(contentsOf: books.results)
                }
            case .failure(let error):
                print(error)
                if (self?.offset ?? 0) > 0 {
                    self?.offset -= 20
                }
            }
        }
    }

    func resetBooksList(categoryName: String) {
        offset = 0
        self.categoryName = categoryName
        fetchBooks()
    }

    func incrementOffSetAndFetch() {
        offset += 20
        fetchBooks()
    }

    func numberOfBooks() -> Int {
        return booksModel?.books?.results.count ?? 0
    }

    func bookName(at indexPath: IndexPath) -> String {
        return booksModel?.books?.results[indexPath.row].bookDetails.first?.title ?? ""
    }

    func bookAbstract(at indexPath: IndexPath) -> String {
        return booksModel?.books?.results[indexPath.row].bookDetails.first?.description ?? ""
    }

    func bookAuthoredBy(at indexPath: IndexPath) -> String {
        return booksModel?.books?.results[indexPath.row].bookDetails.first?.author ?? ""
    }

    func bookPublishedBy(at indexPath: IndexPath) -> String {
        return booksModel?.books?.results[indexPath.row].bookDetails.first?.publisher ?? ""
    }

    func bookPrimaryisbn10(at indexPath: IndexPath) -> String {
        return booksModel?.books?.results[indexPath.row].bookDetails.first?.primaryIsbn10 ?? ""
    }

    func bookPublishDate(at indexPath: IndexPath) -> String {
        return booksModel?.books?.results[indexPath.row].publishedDate ?? ""
    }
}
