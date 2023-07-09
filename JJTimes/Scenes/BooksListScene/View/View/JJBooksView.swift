//
//  JJBooksView.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 30/06/2023.
//

import UIKit
import SDWebImage
import DropDown

class JJBooksView: UIView {

    var titleLabel: UILabel!
    var underlineLabel: UILabel!
    var filterImageButton: UIButton!
    var filterImageView: UIImageView!
    var bookListTableView: UITableView!
    var booksViewModel: JJBooksViewModel!
    let filterDropDown = DropDown()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "jjAppWhiteColor")
        setupUI()
        setupViewModel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI() {
        addFilterImageView()
        setupFilterImageView()
        addFilterButton()
        setupFilterButton()
        addTitleLabel()
        setupTitleLabel()
        addUnderLineLabel()
        setupUnderLineLabel()
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
        titleLabel.autoPinEdge(.top, to: .bottom, of: filterImageButton)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    fileprivate func addUnderLineLabel() {
        underlineLabel = UILabel(forAutoLayout: ())
        self.addSubview(underlineLabel)
        underlineLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 5)
        underlineLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -4).isActive = true
        underlineLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 4).isActive = true
        underlineLabel.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }

    fileprivate func setupUnderLineLabel() {
        underlineLabel.backgroundColor = UIColor(named: "jjAppBlackColor")
    }

    fileprivate func setupTitleLabel() {
        titleLabel.text = "NY Times Most Popular Books"
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
        filterImageButton.addTarget(self, action: #selector(selectDropDown), for: .touchUpInside)
    }

    @objc func selectDropDown(sender: AnyObject) {
        filterDropDown.show()
        filterDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let encodedCategory = self.booksViewModel.categoriesModel?.results.first(where: { category in
                category.displayName == item
            })
            self.booksViewModel.resetBooksList(categoryName: encodedCategory?.listNameEncoded ?? "")
        }
    }

    fileprivate func addTableView() {
        bookListTableView = UITableView(forAutoLayout: ())
        self.addSubview(bookListTableView)
        bookListTableView.autoPinEdge(.top, to: .bottom, of: underlineLabel, withOffset: 5)
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
        bookListTableView.separatorStyle = .none
    }

    fileprivate func configureDropDown() {
        filterDropDown.anchorView = filterImageButton
        filterDropDown.dataSource = booksViewModel.categoriesModel?.results.map { $0.displayName } ?? [String]()
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= booksViewModel.numberOfBooks() - 10 {
            booksViewModel.incrementOffSetAndFetch()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = JJBookDetailVC()
        controller.modalTransitionStyle = .crossDissolve
        controller.bookCategory = booksViewModel.categoryName
        controller.bookPublishedDate = booksViewModel.bookPublishDate(at: indexPath)
        controller.primaryisbn10 = booksViewModel.bookPrimaryisbn10(at: indexPath)
        self.findViewController()?.present(controller, animated: true)
    }
}

extension JJBooksView: JJTopStoriesViewModelDelegate {
    func stopLoading() {
        self.hideLoading()
    }
    
    func startLoading() {
        self.showLoading(showProgress: true)
    }
    
    func categoriesDidFetch() {
        configureDropDown()
    }
    
    func booksDidFetch() {
        bookListTableView.reloadData()
    }

    func newsViewModel(_ viewModel: JJBooksViewModel, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        findViewController()?.present(alert, animated: true, completion: nil)
    }
}
