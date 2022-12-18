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
        remoteRepository.fetchRemoteRepos { result in
            switch result {
            case .success(let response):
                completion(.success(response.repos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
