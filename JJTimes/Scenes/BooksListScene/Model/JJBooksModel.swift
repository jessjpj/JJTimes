//
//  JJBooksModel.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation
class JJBooksModel: Codable, Equatable {
    static func == (lhs: JJBooksModel, rhs: JJBooksModel) -> Bool {
        return lhs.books == rhs.books
    }

    var books: JJBooksResultsModel?

    init(model: JJBooksResultsModel? = nil) {
        if let inputModel = model {
            self.books = inputModel
        }
    }
}

// MARK: - JJBooksResults
public struct JJBooksResultsModel: Codable, Equatable {
    let numResults: Int
    let lastModified: String
    var results: [JJBooksResult]

    enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case lastModified = "last_modified"
        case results
    }
}

// MARK: - Result
struct JJBooksResult: Codable, Equatable {
    static func == (lhs: JJBooksResult, rhs: JJBooksResult) -> Bool {
        return lhs.bookDetails == rhs.bookDetails
    }
    
    let listName, displayName: String
    let bestsellersDate, publishedDate: String
    let rank, rankLastWeek, weeksOnList, asterisk: Int
    let dagger: Int
    let amazonProductURL: String
    let isbns: [Isbn]
    let bookDetails: [BookDetail]
    let reviews: [Review]

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case rank
        case rankLastWeek = "rank_last_week"
        case weeksOnList = "weeks_on_list"
        case asterisk, dagger
        case amazonProductURL = "amazon_product_url"
        case isbns
        case bookDetails = "book_details"
        case reviews
    }
}

// MARK: - BookDetail
struct BookDetail: Codable, Equatable {
    let title, description, contributor, author: String
    let contributorNote, price, ageGroup, publisher: String
    let primaryIsbn13, primaryIsbn10: String

    enum CodingKeys: String, CodingKey {
        case title, description, contributor, author
        case contributorNote = "contributor_note"
        case price
        case ageGroup = "age_group"
        case publisher
        case primaryIsbn13 = "primary_isbn13"
        case primaryIsbn10 = "primary_isbn10"
    }
}

// MARK: - Isbn
struct Isbn: Codable {
    let isbn10, isbn13: String
}

// MARK: - Review
struct Review: Codable {
    let bookReviewLink, firstChapterLink, sundayReviewLink, articleChapterLink: String

    enum CodingKeys: String, CodingKey {
        case bookReviewLink = "book_review_link"
        case firstChapterLink = "first_chapter_link"
        case sundayReviewLink = "sunday_review_link"
        case articleChapterLink = "article_chapter_link"
    }
}
