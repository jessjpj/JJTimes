//
//  JJTopStoriesTVC.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 02/07/2023.
//

import UIKit
import PureLayout

class JJTopStoriesTVC: UITableViewCell {

    var topStoryThumbNailImageView: UIImageView!
    var topStoryTitleLabel: UILabel!
    var topStoryAbstractLabel: UILabel!
    var topStoryPublishedDateLabel: UILabel!
    var topStoryContentsStackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        topStoryThumbNailImageView = UIImageView()
        contentView.addSubViewWithConstraints(subview: topStoryThumbNailImageView)
        topStoryTitleLabel = UILabel()
        topStoryAbstractLabel = UILabel()
        topStoryPublishedDateLabel = UILabel()
        topStoryContentsStackView = UIStackView(arrangedSubviews: [topStoryTitleLabel, topStoryAbstractLabel, topStoryPublishedDateLabel])
        contentView.addSubViewWithConstraints(subview: topStoryContentsStackView)
    }

    fileprivate func setConstraintsForSubViews() {
        topStoryThumbNailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        topStoryThumbNailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        let imageViewBottomAnchorConstraint = topStoryThumbNailImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        imageViewBottomAnchorConstraint.isActive = true
        imageViewBottomAnchorConstraint.priority = .init(rawValue: 999.0)
        topStoryThumbNailImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        topStoryContentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        topStoryContentsStackView.leftAnchor.constraint(equalTo: topStoryThumbNailImageView.rightAnchor, constant: 5).isActive = true
        topStoryContentsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        let stackViewBottomAnchorConstraint = topStoryContentsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        stackViewBottomAnchorConstraint.isActive = true
        stackViewBottomAnchorConstraint.priority = .init(rawValue: 999.0)
    }

    fileprivate func setupStyles() {
        topStoryThumbNailImageView.contentMode = .scaleAspectFit
        topStoryTitleLabel.numberOfLines = 0
        topStoryTitleLabel.font = .systemFont(ofSize: 14)
        topStoryAbstractLabel.numberOfLines = 2
        topStoryAbstractLabel.font = .systemFont(ofSize: 12)
        topStoryPublishedDateLabel.numberOfLines = 1
        topStoryPublishedDateLabel.font = .systemFont(ofSize: 10)
        topStoryPublishedDateLabel.textColor = .gray
        topStoryContentsStackView.distribution = .fill
        topStoryContentsStackView.axis = .vertical
        topStoryContentsStackView.spacing = 2
    }
}
