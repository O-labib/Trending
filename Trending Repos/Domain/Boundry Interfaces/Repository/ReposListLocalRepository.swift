//
//  MoviesListLocalRepository.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

protocol ReposListLocalRepository {
    func localRepos() -> [Repo]
    func storeRepos(_ repos: [Repo])
}
