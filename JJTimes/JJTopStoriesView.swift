//
//  JJTopStoriesView.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 30/06/2023.
//

import UIKit
import SDWebImage

class JJTopStoriesView: UIView {

    var titleLabel: UILabel!
    var topStoriesTableView: UITableView!
    var newsViewModel: JJTopStoriesViewModel!

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
        addTableView()
        setupTableView()
    }

    private func setupViewModel() {
        newsViewModel = JJTopStoriesViewModel(newsRepository: JJRepository(), dispatchQueue: DispatchQueue.main)
        newsViewModel.delegate = self
        newsViewModel.fetchNews()
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
        titleLabel.textAlignment = .center
    }

    fileprivate func addTableView() {
        topStoriesTableView = UITableView(forAutoLayout: ())
        self.addSubview(topStoriesTableView)
        topStoriesTableView.autoPinEdge(.top, to: .bottom, of: titleLabel)
        topStoriesTableView.autoPinEdge(toSuperviewEdge: .left)
        topStoriesTableView.autoPinEdge(toSuperviewEdge: .right)
        topStoriesTableView.autoPinEdge(toSuperviewEdge: .bottom)
        topStoriesTableView.backgroundColor = .green
    }

    fileprivate func setupTableView() {
        topStoriesTableView.register(JJTopStoriesTVC.self, forCellReuseIdentifier: JJTopStoriesTVC.reuseIdentifier)
        topStoriesTableView.delegate = self
        topStoriesTableView.dataSource = self
        topStoriesTableView.rowHeight = UITableView.automaticDimension
        topStoriesTableView.estimatedRowHeight = 400
    }
}

extension JJTopStoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JJTopStoriesTVC = tableView.dequeueReusableCell(for: indexPath)
        cell.topStoryThumbNailImageView.sd_setImage(with: newsViewModel.thumbNailImageURL(at: indexPath), placeholderImage: nil, context: nil)
        cell.topStoryTitleLabel.text = newsViewModel.newsName(at: indexPath)
        cell.topStoryAbstractLabel.text = newsViewModel.newsAbstract(at: indexPath)
        cell.topStoryPublishedDateLabel.text = "Published on: \(newsViewModel.newsPublishedDate(at: indexPath))"
        return cell
    }

}

extension JJTopStoriesView: UITableViewDelegate {
    
}

extension JJTopStoriesView: JJTopStoriesViewModelDelegate {
    func newsDidFetch() {
        topStoriesTableView.reloadData()
    }

    func newsViewModel(_ viewModel: JJTopStoriesViewModel, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        findViewController()?.present(alert, animated: true, completion: nil)
    }
}
