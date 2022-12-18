//
//  ReposListCell.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

class ReposListCell: UITableViewCell {
    var viewModel: ViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension ReposListCell {
    struct ViewModel: Equatable {
        let repoTitle: String
    }
}
