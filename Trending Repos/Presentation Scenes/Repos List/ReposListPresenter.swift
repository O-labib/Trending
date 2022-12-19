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
        presentLoadingState()
        
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
        presentLoadingState()
        
        reposListUseCase.fetchRemoteRepos { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let repos):
                self.presentLoadedState(repos)
            case .failure:
                self.presentErrorState()
            }
        }
    }

    func reloadRepos() {
        loadAvailableRepos()
    }
    
    func convert(_ repo: Repo) -> ReposListCell.ViewModel {
        .init(
            ownerAvatarURL: repo.owner?.avatarUrl,
            ownerName: repo.owner?.name,
            repoTitle: repo.name,
            repoDescription: repo.description,
            repoLanguage: repo.language,
            repoStart: repo.stargazersCount != nil ? String(repo.stargazersCount!) : nil
        )
    }
}

private extension ReposListPresenter {
    func presentLoadingState() {
        view?.updateViewState(.loading(count: 10))
    }
    
    func presentErrorState() {
        view?.updateViewState(.failed)
    }
    
    func presentLoadedState(_ repos: [Repo]) {
        let viewModels = repos.map(convert(_:))
        
        view?.updateViewState(.loaded(viewModel: viewModels))
    }
}
