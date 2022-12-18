//
//  Entities.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

struct Repo {
    let owner: Owner
    let name: String
    let description: String
    let language: String
    let stargazersCount: Int
    
    struct Owner {
        let name: String
        let avatarUrl: String
    }
}

enum NetworkError: Error {
    case unknown
}
