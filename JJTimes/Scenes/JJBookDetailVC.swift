//
//  JJBookDetailVC.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 09/07/2023.
//

import UIKit

class JJBookDetailVC: UIViewController {

    var bookDetailView: JJBookDetailView?
    var primaryisbn10: String = ""
    var bookPublishedDate: String = ""
    var bookCategory: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        addBookDetailView()
    }

    fileprivate func addBookDetailView() {
        bookDetailView = JJBookDetailView(frame: CGRect.zero)
        guard let bookDetailView = bookDetailView else { return }
        bookDetailView.primaryisbn10 = primaryisbn10
        bookDetailView.bookPublishedDate = bookPublishedDate
        bookDetailView.bookCategory = bookCategory
        self.view.addSubview(bookDetailView)
        bookDetailView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    }

}
