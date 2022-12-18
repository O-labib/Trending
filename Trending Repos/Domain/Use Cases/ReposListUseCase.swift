//
//  ReposListUseCase.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

protocol ReposListUseCase {
}

class ReposListInteractor: ReposListUseCase {
    let remoteRepository: ReposListRemoteRepository
    let localRepository: ReposListLocalRepository
    
    init(remoteRepository: ReposListRemoteRepository, localRepository: ReposListLocalRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}
