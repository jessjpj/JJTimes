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
    var containerView: UIView!

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
        containerView = UIView()
        bookTitleLabel = UILabel()
        bookAbstractLabel = UILabel()
        bookAuthorLabel = UILabel()
        bookPublisherLabel = UILabel()
        bookContentsStackView = UIStackView(arrangedSubviews: [bookTitleLabel, bookAbstractLabel, bookAuthorLabel, bookPublisherLabel])
        containerView.addSubViewWithConstraints(subview: bookContentsStackView)
        contentView.addSubViewWithConstraints(subview: containerView)
    }

    fileprivate func setConstraintsForSubViews() {
        bookContentsStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        bookContentsStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        bookContentsStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        bookContentsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
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
        containerView.layer.borderColor = UIColor(named: "jjAppBlackColor")?.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
}
