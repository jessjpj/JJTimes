//
//  JJBookListVC.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 30/06/2023.
//

import UIKit
import PureLayout

class JJBookListVC: UIViewController {

    var topStoriesView: JJBooksView?
    override func viewDidLoad() {
        super.viewDidLoad()
        addBooksView()
    }

    func addBooksView() {
        topStoriesView = JJBooksView(frame: CGRect.zero)
        guard let topStoriesView = topStoriesView else { return }
        self.view.addSubview(topStoriesView)
        topStoriesView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
