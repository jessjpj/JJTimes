//
//  UIView+Extension.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 02/07/2023.
//

import UIKit

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
