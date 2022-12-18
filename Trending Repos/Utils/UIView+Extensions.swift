//
//  UIView+Extensions.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

extension UIView {
    func setCircular() {
        layer.cornerRadius = frame.size.width/2
         clipsToBounds = true
    }
}
