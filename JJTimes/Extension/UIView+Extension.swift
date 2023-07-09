//
//  UIView+Extension.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 02/07/2023.
//

import UIKit
import ANActivityIndicator

extension UIView {
    func addSubViewWithConstraints(subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension UIView {
    func showLoading(showProgress: Bool) {
        self.isUserInteractionEnabled = false
        if showProgress {
            ANActivityIndicatorPresenter.shared.showIndicator(
                    CGSize(width: 60, height: 60),
                    animationType: ANActivityIndicatorAnimationType.lineScaleParty)
        }
    }

    func hideLoading() {
        self.isUserInteractionEnabled = true
        ANActivityIndicatorPresenter.shared.hideIndicator()
    }
}
