//
//  ReposListLocalService.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

class ReposListLocalService: ReposListLocalRepository {
    let localClient: LocalStorageClient
    
    init(localClient: LocalStorageClient) {
        self.localClient = localClient
    }
}
