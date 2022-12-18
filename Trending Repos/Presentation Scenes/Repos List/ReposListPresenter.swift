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
        reposListUseCase.fetchAvailableRepos { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let repos):
                self.presentLoadedState(repos)
            case .failure:
                self.presentErrorState()
            }
        }
    }
    
    func refreshRepos() {
    }

    func reloadRepos() {
    }
    
    func convert(_ repo: Repo) -> ReposListCell.ViewModel {
        .init(
            ownerAvatarURL: repo.owner.avatarUrl,
            ownerName: repo.owner.name,
            repoTitle: repo.name,
            repoDescription: repo.description,
            repoLanguage: repo.language,
            repoStart: String(repo.stargazersCount)
        )
    }
}

private extension ReposListPresenter {
    func presentErrorState() {
        view?.updateViewState(.failed)
    }
    
    func presentLoadedState(_ repos: [Repo]) {
        let viewModels = repos.map(convert(_:))
        
        view?.updateViewState(.loaded(viewModel: viewModels))
    }
}
