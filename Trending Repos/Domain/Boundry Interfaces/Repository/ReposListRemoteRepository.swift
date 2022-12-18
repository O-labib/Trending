//
//  MoviesListRemoteRepository.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

protocol ReposListRemoteRepository {
    func fetchRemoteRepos(_ completion: @escaping (Result<Response, NetworkError>) -> Void)
}
