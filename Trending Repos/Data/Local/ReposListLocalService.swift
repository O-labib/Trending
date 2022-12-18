//
//  ReposListLocalService.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

class ReposListLocalService {
    let localClient: LocalStorageClient
    
    init(localClient: LocalStorageClient) {
        self.localClient = localClient
    }
}

extension ReposListLocalService: ReposListLocalRepository {
    func storeRepos(_ repos: [Repo]) {
    }
    func localRepos() -> [Repo] {
        fatalError()
    }
}
