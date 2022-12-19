//
//  ReposListFailureCell.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit
import Lottie

class ReposListFailureCell: UITableViewCell {
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var retryButton: UIButton!
    
    var retryAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    @IBAction func retryAction(_ sender: Any) {
        retryAction?()
    }
}
