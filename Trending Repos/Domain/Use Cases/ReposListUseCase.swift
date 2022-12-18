//
//  ReposListUseCase.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

protocol ReposListUseCase {
    func fetchAvailableRepos(_ completion: (Result<[Repo], Error>) -> Void)
}

class ReposListInteractor {
    let remoteRepository: ReposListRemoteRepository
    let localRepository: ReposListLocalRepository
    
    init(remoteRepository: ReposListRemoteRepository, localRepository: ReposListLocalRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension ReposListInteractor: ReposListUseCase {
    func fetchAvailableRepos(_ completion: (Result<[Repo], Error>) -> Void) {
    }
}
