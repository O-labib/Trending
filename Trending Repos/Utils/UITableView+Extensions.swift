//
//  UITableView+Extensions.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

extension UITableView {
    func register(cellType types: UITableViewCell.Type...) {
        types.forEach { type in
            let name = String(describing: type)
            let bundle = Bundle(for: type)
            if bundle.path(forResource: name, ofType: "nib") != nil {
                register(UINib(nibName: name, bundle: bundle), forCellReuseIdentifier: name)
            } else {
                register(type, forCellReuseIdentifier: name)
            }
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
}
