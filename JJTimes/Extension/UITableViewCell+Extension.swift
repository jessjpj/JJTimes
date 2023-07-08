//
//  UITableViewCell+Extension.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
