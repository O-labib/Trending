//
//  Entities.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

struct Response: Equatable {
    let repos: [Repo]
}

struct Repo: Equatable {
    let owner: Owner
    let name: String
    let description: String
    let language: String
    let stargazersCount: Int
    
    struct Owner: Equatable {
        let name: String
        let avatarUrl: String
    }
}

enum NetworkError: Error, Equatable {
    case unknown
}
