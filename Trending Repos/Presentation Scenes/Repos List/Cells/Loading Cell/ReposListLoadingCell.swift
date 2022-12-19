//
//  ReposListLoadingCell.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit
import UIView_Shimmer

class ReposListLoadingCell: UITableViewCell, ShimmeringViewProtocol {
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var descriptionView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        setTemplateWithSubviews(true, viewBackgroundColor: .secondarySystemBackground)
    }

    var shimmeringAnimatedItems: [UIView] {
        [
            avatarView,
            titleView,
            descriptionView
        ]
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarView.setCircular()
    }
}
