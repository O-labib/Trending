//
//  UIImageView+Extensions.swift
//  Trending Repos
//
//  Created by Omar Labib on 19/12/2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(from url: String?) {
        guard let url, let imageURL = URL(string: url) else {
            return
        }
        
        kf.setImage(with: imageURL, placeholder: UIImage(named: "Placeholder"))
    }
}
