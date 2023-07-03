//
//  JJTopStoriesView.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 30/06/2023.
//

import UIKit

class JJTopStoriesView: UIView {

    var topStoriesTableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addTableView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    fileprivate func addTableView() {
        topStoriesTableView = UITableView(forAutoLayout: ())
        self.addSubViewWithConstraints(subview: topStoriesTableView)
        topStoriesTableView.autoCenterInSuperview()
        topStoriesTableView.backgroundColor = .green
        topStoriesTableView.delegate = self
        topStoriesTableView.dataSource = self
    }
}

extension JJTopStoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension JJTopStoriesView: UITableViewDelegate {
    
}
