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

    private func setupViewModel() {
        bookDetailViewModel = JJBookDetailViewModel(bookDetailsRepository: JJRepository(), dispatchQueue: DispatchQueue.main, primaryisbn10: primaryisbn10, bookPublishedDate: bookPublishedDate, bookCategory: bookCategory)
        bookDetailViewModel.delegate = self
        bookDetailViewModel.fetchBookDetails()
    }

    private func loadUI() {
        bookDetailImageView.sd_setImage(with: URL(string: bookDetailViewModel.bookImage()))
    }
}

extension JJBookDetailView: JJBookDetailViewModelDelegate {
    func bookDetailDidFetch() {
        loadUI()
    }

}
