//
//  JJBooksView.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 30/06/2023.
//

import UIKit
import SDWebImage

class JJBooksView: UIView {

    var titleLabel: UILabel!
    var filterImageButton: UIButton!
    var filterImageView: UIImageView!
    var bookListTableView: UITableView!
    var booksViewModel: JJBooksViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
        setupViewModel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI() {
        addTitleLabel()
        setupTitleLabel()
        addFilterImageView()
        setupFilterImageView()
        addFilterButton()
        setupFilterButton()
        addTableView()
        setupTableView()
    }

    private func setupViewModel() {
        booksViewModel = JJBooksViewModel(newsRepository: JJRepository(), dispatchQueue: DispatchQueue.main, offset: 0, categoryName: "")
        booksViewModel.delegate = self
        booksViewModel.fetchCategories()
    }

    fileprivate func addTitleLabel() {
        titleLabel = UILabel(forAutoLayout: ())
        self.addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
    }

    fileprivate func setupTitleLabel() {
        titleLabel.text = "NY Times Most Popular"
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.textAlignment = .center
    }

    fileprivate func addFilterImageView() {
        filterImageView = UIImageView(forAutoLayout: ())
        self.addSubview(filterImageView)
        filterImageView.autoPinEdge(toSuperviewSafeArea: .top)
        filterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        filterImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        filterImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }

    fileprivate func setupFilterImageView() {
        filterImageView.tintColor = UIColor(named: "jjAppBlackColor")
        filterImageView.image = UIImage(named: "jjFilterIcon")
        filterImageView.contentMode = .scaleAspectFit
    }

    fileprivate func addFilterButton() {
        filterImageButton = UIButton(forAutoLayout: ())
        self.addSubview(filterImageButton)
        filterImageButton.autoPinEdge(toSuperviewSafeArea: .top)
        filterImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        filterImageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        filterImageButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }

    fileprivate func setupFilterButton() {
        
    }

    fileprivate func addTableView() {
        bookListTableView = UITableView(forAutoLayout: ())
        self.addSubview(bookListTableView)
        bookListTableView.autoPinEdge(.top, to: .bottom, of: titleLabel)
        bookListTableView.autoPinEdge(toSuperviewEdge: .left)
        bookListTableView.autoPinEdge(toSuperviewEdge: .right)
        bookListTableView.autoPinEdge(toSuperviewEdge: .bottom)
    }

    fileprivate func setupTableView() {
        bookListTableView.register(JJBookTVC.self, forCellReuseIdentifier: JJBookTVC.reuseIdentifier)
        bookListTableView.delegate = self
        bookListTableView.dataSource = self
        bookListTableView.rowHeight = UITableView.automaticDimension
        bookListTableView.estimatedRowHeight = 400
    }
}

extension JJBooksView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksViewModel.numberOfBooks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JJBookTVC = tableView.dequeueReusableCell(for: indexPath)
        cell.bookTitleLabel.text = booksViewModel.bookName(at: indexPath)
        cell.bookAbstractLabel.text = booksViewModel.bookAbstract(at: indexPath)
        cell.bookAuthorLabel.text = "Author: \(booksViewModel.bookAuthoredBy(at: indexPath))"
        cell.bookPublisherLabel.text = "Publisher: \(booksViewModel.bookPublishedBy(at: indexPath))"
        return cell
    }

}

extension JJBooksView: UITableViewDelegate {
    
}

extension JJBooksView: JJTopStoriesViewModelDelegate {
    func booksDidFetch() {
        bookListTableView.reloadData()
    }

    func newsViewModel(_ viewModel: JJBooksViewModel, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        findViewController()?.present(alert, animated: true, completion: nil)
    }
}
