//
//  ReposListUseCase.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

protocol ReposListUseCase {
    func fetchAvailableRepos(_ completion: @escaping (Result<[Repo], Error>) -> Void)
    func fetchRemoteRepos(_ completion: @escaping (Result<[Repo], Error>) -> Void)
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
    func fetchAvailableRepos(_ completion: @escaping (Result<[Repo], Error>) -> Void) {
        guard !localRepository.localRepos().isEmpty else {
            return fetchRemoteRepos(completion)
        }
        completion(.success(localRepository.localRepos()))
    }
    
    func fetchRemoteRepos(_ completion: @escaping (Result<[Repo], Error>) -> Void) {
        remoteRepository.fetchRemoteRepos { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.localRepository.storeRepos(response.repos)
                completion(.success(response.repos))
            case .failure(let error):
                let localRepos = self.localRepository.localRepos()
                guard localRepos.isEmpty else {
                    return completion(.success(localRepos))
                }
                
                completion(.failure(error))
            }
        }
    }
}
