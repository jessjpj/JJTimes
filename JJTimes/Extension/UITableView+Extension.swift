//
//  UITableView+Extension.swift
//  JJTimes
//
//  Created by Jeslin Johnson on 03/07/2023.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }

    func registerCells(identifiers: [String]) {
        for identifier in identifiers {
            if identifier.isEmpty {
                continue
            }
            let cell = UINib(nibName: identifier, bundle: nil)
            register(cell, forCellReuseIdentifier: identifier)
        }
    }
}
