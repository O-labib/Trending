//
//  ReposListPresenter.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

class ReposListPresenter {
    weak var view: ReposListViewProtocol?
    let reposListUseCase: ReposListUseCase
    
    init(view: ReposListViewProtocol?, reposListUseCase: ReposListUseCase) {
        self.view = view
        self.reposListUseCase = reposListUseCase
    }
}

extension ReposListPresenter: ReposListPresenterProtocol {
    func loadAvailableRepos() {
    }
}
