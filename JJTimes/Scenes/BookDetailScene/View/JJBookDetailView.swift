//
//  JJBookDetailView.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import UIKit

class JJBookDetailView: UIView {

    var primaryisbn10: String = ""
    var bookPublishedDate: String = ""
    var bookCategory: String = "" {
        didSet {
            setupViewModel()
        }
    }
    var bookDetailViewModel: JJBookDetailViewModel!

    let bookDetailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let bookDetailScrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var bookDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let bookDetailsView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bookDetailStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    var publisherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "jjAppWhiteColor")
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI() {
        self.addSubview(bookDetailScrollView)
        bookDetailScrollView.addSubview(bookDetailScrollViewContainer)
        bookDetailScrollViewContainer.addArrangedSubview(bookDetailImageView)
        bookDetailScrollViewContainer.addArrangedSubview(bookDetailsView)

        bookDetailsView.addSubview(bookDetailStackView)
        bookDetailStackView.leadingAnchor.constraint(equalTo: bookDetailsView.leadingAnchor, constant: 5).isActive = true
        bookDetailStackView.trailingAnchor.constraint(equalTo: bookDetailsView.trailingAnchor, constant: -5).isActive = true
        bookDetailStackView.topAnchor.constraint(equalTo: bookDetailsView.topAnchor, constant: 5).isActive = true
        bookDetailStackView.bottomAnchor.constraint(equalTo: bookDetailsView.bottomAnchor, constant: 5).isActive = true

        bookDetailStackView.addArrangedSubview(titleLabel)
        bookDetailStackView.addArrangedSubview(descriptionLabel)
        bookDetailStackView.addArrangedSubview(authorLabel)
        bookDetailStackView.addArrangedSubview(publisherLabel)

        bookDetailScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bookDetailScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bookDetailScrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bookDetailScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        bookDetailScrollViewContainer.leadingAnchor.constraint(equalTo: bookDetailScrollView.leadingAnchor).isActive = true
        bookDetailScrollViewContainer.trailingAnchor.constraint(equalTo: bookDetailScrollView.trailingAnchor).isActive = true
        bookDetailScrollViewContainer.topAnchor.constraint(equalTo: bookDetailScrollView.topAnchor).isActive = true
        bookDetailScrollViewContainer.bottomAnchor.constraint(equalTo: bookDetailScrollView.bottomAnchor).isActive = true
        bookDetailScrollViewContainer.widthAnchor.constraint(equalTo: bookDetailScrollView.widthAnchor).isActive = true
    }

    func setupViewModel() {
        if bookDetailViewModel == nil {
            bookDetailViewModel = JJBookDetailViewModel(bookDetailsRepository: JJRepository(), dispatchQueue: DispatchQueue.main, primaryisbn10: primaryisbn10, bookPublishedDate: bookPublishedDate, bookCategory: bookCategory)
        }
        callAPI()
    }

    func callAPI() {
        bookDetailViewModel.delegate = self
        bookDetailViewModel.fetchBookDetails()
    }

    func loadUI() {
        bookDetailImageView.sd_setImage(with: URL(string: bookDetailViewModel.bookImage()))
        titleLabel.text = bookDetailViewModel.bookTitle()
        descriptionLabel.text = bookDetailViewModel.bookDescription()
        authorLabel.text = "Authored by: \(bookDetailViewModel.bookAuthor())"
        publisherLabel.text = "Published by: \(bookDetailViewModel.bookPublisher())"
    }
}

extension JJBookDetailView: JJBookDetailViewModelDelegate {
    func startLoading() {
        self.showLoading(showProgress: true)
    }
    
    func stopLoading() {
        self.hideLoading()
    }
    
    func bookDetailDidFetch() {
        loadUI()
    }

}
