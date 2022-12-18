//
//  ReposListProtocols.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

protocol ReposListPresenterProtocol {
}

protocol ReposListViewProtocol where Self: AnyObject {
    func updateViewState(_ state: ReposListViewController.State)
}
