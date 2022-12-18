//
//  ReposListViewController.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

class ReposListViewController: UIViewController {
    var presenter: ReposListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ReposListViewController: ReposListViewProtocol {
}
