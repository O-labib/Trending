//
//  ReposListCell.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

class ReposListCell: UITableViewCell {
    var viewModel: ViewModel?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var languageColoredView: UIView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.setCircular()
        languageColoredView.setCircular()
    }
}

extension ReposListCell {
    struct ViewModel: Equatable {
        let repoTitle: String
        var isExpanded = false
    }
}
