//
//  JJTopStoriesViewModel.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import Foundation

protocol JJTopStoriesViewModelDelegate: AnyObject {
    func newsDidFetch()
}

class JJTopStoriesViewModel {

    private let newsRepository: JJRepository
    private let dispatchQueue: JJDispatchQueueType

    var newsModel: JJTopStoriesModel? {
        didSet {
            dispatchQueue.async {
                self.delegate?.newsDidFetch()
            }
        }
    }

    weak var delegate: JJTopStoriesViewModelDelegate?

    init(newsRepository: JJRepository, dispatchQueue: JJDispatchQueueType) {
        self.newsRepository = newsRepository
        self.dispatchQueue = dispatchQueue
    }

    func fetchNews() {
        newsRepository.fetchNews(period: 7) { [weak self] result in
            switch result {
            case .success(let news):
                self?.newsModel = JJTopStoriesModel(model: news)
            case .failure(let error):
                print(error)
            }
        }
    }

    func thumbNailImageURL(at indexPath: IndexPath) -> URL? {
        guard let imageURL = newsModel?.news?.news[indexPath.row].media.first(where: { media in
            media.type == .image
        })?.mediaMetadata.first(where: { mediaMetaData in
            mediaMetaData.format == .standardThumbnail
        })?.url else { return nil }
        return URL(string: imageURL)
    }

    func numberOfNews() -> Int {
        return newsModel?.news?.news.count ?? 0
    }

    func newsName(at indexPath: IndexPath) -> String {
        return newsModel?.news?.news[indexPath.row].title ?? ""
    }

    func newsAbstract(at indexPath: IndexPath) -> String {
        return newsModel?.news?.news[indexPath.row].abstract ?? ""
    }

    func newsPublishedBy(at indexPath: IndexPath) -> String {
        return newsModel?.news?.news[indexPath.row].byline ?? ""
    }

    func newsPublishedDate(at indexPath: IndexPath) -> String {
        return newsModel?.news?.news[indexPath.row].publishedDate ?? ""
    }
}
