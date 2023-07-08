//
//  JJBookTVC.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 02/07/2023.
//

import UIKit
import PureLayout

class JJBookTVC: UITableViewCell {

    var bookTitleLabel: UILabel!
    var bookAbstractLabel: UILabel!
    var bookAuthorLabel: UILabel!
    var bookPublisherLabel: UILabel!
    var bookContentsStackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        addSubViews()
        setConstraintsForSubViews()
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    fileprivate func addSubViews() {
        bookTitleLabel = UILabel()
        bookAbstractLabel = UILabel()
        bookAuthorLabel = UILabel()
        bookPublisherLabel = UILabel()
        bookContentsStackView = UIStackView(arrangedSubviews: [bookTitleLabel, bookAbstractLabel, bookAuthorLabel, bookPublisherLabel])
        contentView.addSubViewWithConstraints(subview: bookContentsStackView)
    }

    fileprivate func setConstraintsForSubViews() {
        bookContentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        bookContentsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        bookContentsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        let stackViewBottomAnchorConstraint = bookContentsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        stackViewBottomAnchorConstraint.isActive = true
        stackViewBottomAnchorConstraint.priority = .init(rawValue: 999.0)
    }

    fileprivate func setupStyles() {
        bookTitleLabel.numberOfLines = 0
        bookTitleLabel.font = .boldSystemFont(ofSize: 16)
        bookAbstractLabel.numberOfLines = 0
        bookAbstractLabel.font = .boldSystemFont(ofSize: 14)
        bookAuthorLabel.numberOfLines = 0
        bookAuthorLabel.font = .systemFont(ofSize: 12)
        bookPublisherLabel.numberOfLines = 0
        bookPublisherLabel.font = .systemFont(ofSize: 12)
        bookContentsStackView.distribution = .fill
        bookContentsStackView.axis = .vertical
        bookContentsStackView.spacing = 2
    }
}
