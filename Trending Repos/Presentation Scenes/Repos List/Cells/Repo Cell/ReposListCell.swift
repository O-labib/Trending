//
//  ReposListCell.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

class ReposListCell: UITableViewCell {
    var viewModel: ViewModel? {
        didSet {
            configure()
        }
    }

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

    private func configure() {
        guard let viewModel else { return }

        avatarImageView.load(from: viewModel.ownerAvatarURL)
        ownerNameLabel.text = viewModel.ownerName
        repoTitleLabel.text = viewModel.repoTitle
        repoDescriptionLabel.text = viewModel.repoDescription
        languageLabel.text = viewModel.repoLanguage
        starsLabel.text = viewModel.repoStart

        detailStackView.isHidden = !viewModel.isExpanded
    }
}

extension ReposListCell {
    struct ViewModel: Equatable {
        let ownerAvatarURL: String?
        let ownerName: String?
        let repoTitle: String?
        let repoDescription: String?
        let repoLanguage: String?
        let repoStart: String?
        var isExpanded = false
    }
}
