//
//  ReposListCell.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

class ReposListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension ReposListCell {
    struct ViewModel {
        let repoTitle: String
    }
}
