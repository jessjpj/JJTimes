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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setConstraintsForSubViews()
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
        contentView.addSubViewWithConstraints(subview: topStoryThumbNailImageView)
        contentView.addSubViewWithConstraints(subview: topStoryTitleLabel)
        contentView.addSubViewWithConstraints(subview: topStoryAbstractLabel)
        contentView.addSubViewWithConstraints(subview: topStoryPublishedDateLabel)
    }

    fileprivate func setConstraintsForSubViews() {
        topStoryThumbNailImageView.autoPinEdge(toSuperviewEdge: .top)
        topStoryThumbNailImageView.autoPinEdge(toSuperviewEdge: .bottom)
        topStoryThumbNailImageView.autoPinEdge(toSuperviewEdge: .left)
        
    }
}
